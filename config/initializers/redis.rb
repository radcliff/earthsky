redis_host = ENV['REDIS_HOST']
redis_port = ENV['REDIS_PORT']

if redis_host and redis_port
  $redis = Redis.new(host: redis_host, port: redis_port)
else
  $redis = Redis.new
end
