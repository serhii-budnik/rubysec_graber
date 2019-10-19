Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
  config.redis = { size: 4 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
  config.redis = { size: 1 }
end
