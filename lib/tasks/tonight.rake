namespace :tonight do

  desc "Fetch a new Earth Sky Tonight post"
  task fetch: :environment do
    key = ['tonight', Date.today.to_s].join(':')  # TODO: handle time zone cases

    @tonight = Tonight.new
    reply = $redis.mapped_hmset(key, @tonight.attributes)

    puts key if reply == 'OK'
  end

end



__END__

# other redis key designs:

- key => "tonight" and uses EXPIRE

```
CACHE_EXPIRATION_IN_SECONDS = 86400  # 24 hours

$redis.multi do |redis|
  redis.mapped_hmset(key, attributes)
  redis.expire(key, CACHE_EXPIRATION_IN_SECONDS)
end
```
