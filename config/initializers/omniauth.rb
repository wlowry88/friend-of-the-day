OmniAuth.config.logger = Rails.logger



Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '275700772346-ibg9fas3drh0pvephdpjklsklnkrp6na.apps.googleusercontent.com', 'TzsunqLxldnOSJ7orBfEK514', {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar https://www.google.com/m8/feeds',
    redirect_uri:'http://localhost:3000/auth/google_oauth2/callback'
  }
end