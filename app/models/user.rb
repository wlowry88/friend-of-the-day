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
    gmail_friends = raw_friends.select { |item| item["phoneNumber"]!=nil }
  end

  def parse_friends(get_friends_auth)
    #implement code to take contacts from last line (gmail contacts) and save 
  end



end
