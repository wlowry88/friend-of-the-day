OmniAuth.config.logger = Rails.logger

if ENV['RAILS_ENV'] == 'production'
	HOST = "intouchbetter.herokuapp.com"
else
	HOST = "localhost:3000"
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '275700772346-ibg9fas3drh0pvephdpjklsklnkrp6na.apps.googleusercontent.com', 'TzsunqLxldnOSJ7orBfEK514', {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email, https://www.googleapis.com/auth/calendar, https://www.google.com/m8/feeds, https://www.googleapis.com/auth/plus.login, openid, https://www.googleapis.com/auth/plus.circles.read, https://www.googleapis.com/auth/plus.me', 
    redirect_uri:"http://#{HOST}/auth/google_oauth2/callback"
  }
end