Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:5501", "127.0.0.1:5501", "localhost:5500", "localhost:3003", "127.0.0.1:5500", "127.0.0.1:3303", "localhost:8080", "192.168.1.40:8080"
    resource(
      "/api/*",
      headers: :any,
      credentials: true,
      methods: [:get, :post, :delete, :patch, :put, :option],
    )
  end
end
