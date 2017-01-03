require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Homer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.cache_store = :redis_store, {
        host: ENV["REDIS_PORT_6379_TCP_ADDR"],
        port: ENV["REDIS_PORT_6379_TCP_PORT"],
        db: 0,
        password: ENV["RUBY_DOWNLOAD_SHA256"],
        namespace: "cache"
    }

    config.session_store :redis_store, servers: {
      host: ENV["REDIS_PORT_6379_TCP_ADDR"],
      port: ENV["REDIS_PORT_6379_TCP_PORT"],
      db: 0,
      password: ENV["RUBY_DOWNLOAD_SHA256"],
      namespace: "session"
    }, expires_in: 90.minutes

    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_caching = false
    config.action_mailer.smtp_settings = {
        :openssl_verify_mode  => "none",
        :enable_starttls_auto => true,
        :address              => "smtp.gmail.com",
        :port                 => 587,
        :domain               => "gmail.com",
        :user_name            => "noreply.listengofast@gmail.com",
        :password             => "listengofast42",
        :authentication       => :login,
        :tls => false
    }
  end
end
