require_relative "boot"

require "rails/all"
Dotenv::Railtie.load if defined?(Dotenv)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CricketBoxBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.autoload_paths += %W(#{config.root}/app/serializers)

    # CORS configuration
    config.middleware.use Rack::Cors do
      allow do
        # Allow specific origins (localhost:3000 for development and your production URL)
        origins 'http://localhost:3000', 'https://crikect-box-backend.onrender.com'

        # Allow all resources (e.g., API endpoints)
        resource '*',
          headers: :any,
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          methods: [:get, :post, :options, :delete, :put],
          credentials: true  # Allow cookies/authentication tokens with requests
      end
    end

    # Other configurations...
  end
end
