class User < ActiveRecord::Base
  has_many :friends

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
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

  def send_message
    client = Twilio::REST::Client.new('AC8271516baa7eea011b1b68b65c403a80', '9f02188e2ef08b8e64eed170e946212e')
    client.account.messages.create(
    from: '+19177192242',
    #our number
    to: '+17814391507',
    #will be their's
    body: "hello fool"
    #our message
    )
  end



end
