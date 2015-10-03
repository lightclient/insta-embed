require "instagram"

Instagram.configure do |config|
  config.client_id = Rails.application.secrets.instagram_api_id
  config.client_secret = Rails.application.secrets.instagram_api_client_secret
end

CALLBACK_URL = "http://localhost:3000/instacall"
