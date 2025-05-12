Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3000'  # Allow your frontend
      resource '*', 
        headers: :any, 
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true  # Allows credentials (cookies, auth tokens, etc.)
    end
end
  