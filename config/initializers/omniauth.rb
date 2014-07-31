OmniAuth.config.logger = Rails.logger

if ENV['RAILS_ENV'] == 'production'
	HOST = "intouchbetter.herokuapp.com"
	KEY = ENV['GOOGLE_HEROKU_KEY']
	SECRET = ENV['GOOGLE_HEROKU_SECRET']
else
	HOST = "localhost:3000"
	KEY = ENV['GOOGLE_LOCAL_KEY']
	SECRET = ENV['GOOGLE_LOCAL_SECRET']
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, KEY, SECRET, {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email, https://www.google.com/m8/feeds, https://www.googleapis.com/auth/plus.me', 
    redirect_uri:"http://#{HOST}/auth/google_oauth2/callback"
  }
end