# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Depot::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      authentication: "plain",
      user_name: "skandar1234567@gmail.com",
      password: "skandar15",
      enable_starttls_auto: true
  }
end
