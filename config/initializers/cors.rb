
# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins do |source, env|
      # this proc should return true or false
      # You can dynamically check the database/redis or any other storage for your origins

      # redirect_uriに設定されているURLはCORSを許可したい
      # oauth_applications.redirect_uriには改行区切りで収まっている
      sql = <<~SQL
        SELECT *
        FROM (SELECT DISTINCT regexp_split_to_table(redirect_uri, '\r|\n|\r\n') redirect_uri FROM oauth_applications) x
        WHERE redirect_uri  ~* ?
      SQL
      Doorkeeper::Application.find_by_sql([sql, "^#{source}"]).present?
    end

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
