OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '275700772346-jjllg7c3a799rmgcimhves0pfo4itvns.apps.googleusercontent.com', 'L9T08FGn8vvY9fRyKznPPXTM', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end