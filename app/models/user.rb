class User < ActiveRecord::Base
  has_many :friends

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      #user.picture = auth["info"]["image"]

      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def get_friends(auth)
    access_token = auth.credentials.token

    request = Typhoeus::Request.new(
      "https://www.google.com/m8/feeds/contacts/default/full?max-results=4000",
      headers: { Authorization: "Bearer #{access_token}" }
    )
    response = request.run

    json = Hash.from_xml(response.body).to_json
    friends = JSON.parse(json).map { |friend| friend }

    raw_friends = friends[0][1]["entry"]
    gmail_friends = raw_friends.select { |item| item["phoneNumber"]!=nil && item["phoneNumber"].kind_of?(String) }
  end

  def create_friends(friends)
    #implement code to take contacts from last line (gmail contacts) and save
    friends.each do |contact|
      @friend = Friend.new
      @friend.name = contact["title"]
      @friend.phone_number = contact["phoneNumber"]

      if contact["email"] != nil
        if contact["email"].kind_of?(Array)
          @friend.email = contact["email"][0]["address"]
        else
          @friend.email = contact["email"]["address"]
        end
      else
        @friend.email = "Not provided"
      end
      @friend.user_id = self.id  
      @friend.save
    end
  end

  def get_plus_info(auth)
    access_token = auth.credentials.token
    request = Typhoeus::Request.new(
      "https://www.googleapis.com/plus/v1/people/#{auth["uid"]}",
      headers: { Authorization: "Bearer #{access_token}" }
    )
    response = request.run
    parsed_json = JSON.parse(response.options[:response_body])
    self.cover_photo = parsed_json["cover"]["coverPhoto"]["url"]
    self.profile_photo = auth["info"]["image"]
    self.save
  end

  def send_updated_message
    client = Twilio::REST::Client.new('AC8271516baa7eea011b1b68b65c403a80', '9f02188e2ef08b8e64eed170e946212e')
    client.account.messages.create(
    from: '+19177192242',
    to: self.phone_number,
    body: "Whatup! Your phone number just got updated."
    )
  end

  def remove_duplicates
    ids = self.friends.select("MIN(id) as id").group(:name, :phone_number).collect(&:id)
    self.friends.where.not(id: ids).destroy_all
  end

  def close_friends
    self.friends.where(close_friend: true)
  end

  def friends_not_contacted
    if close_friends.where(contacted: false).count == 0
      reset_contacted 
    end
    close_friends.where(contacted: false)
  end

  def set_friend_of_the_day
    friend = friends_not_contacted.sample  
    get_friend_of_the_day.update_attributes(fotd: false)
    Friend.find(friend.id).update_attributes(fotd: true)
  end

  def get_friend_of_the_day
    Friend.find_by(fotd: true)
  end

  def change_friend_of_the_day
    Friend.find(self.get_friend_of_the_day.id).update_attributes(contacted: true)
  end

  def reset_contacted
    close_friends.update_all(contacted: false)
  end

  def send_reminder
    # binding.pry
    client = Twilio::REST::Client.new('AC8271516baa7eea011b1b68b65c403a80', '9f02188e2ef08b8e64eed170e946212e')
    client.account.messages.create(
    from: '+19177192242',
    to: self.phone_number,
    body: "Hey! Have you reached out to #{self.get_friend_of_the_day.name} lately? Here is their number: #{self.get_friend_of_the_day.phone_number}."
    )
  end

end
