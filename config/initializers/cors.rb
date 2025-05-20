# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      # Allow specific origins (local development and production URLs)
      origins 'http://localhost:3000' 
      # , 'https://crikect-box-backend.onrender.com'
  
      # Allow all resources (e.g., API endpoints)
      resource '*',
        headers: :any,
        expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
        methods: [:get, :post, :options, :delete, :put],
        credentials: true  # Allow credentials (cookies and auth tokens) with requests
    end
end
  