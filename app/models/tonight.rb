class Tonight
  attr_reader :cache, :date, :title, :summary, :img_url, :permalink

  def initialize
    scrape  # grab page from earthsky/tonight

    @cache = cache  # html

    @data = date
    @title = title
    @summary = summary
    @img_url = img_url
    @permalink = permalink
  end


  def self.find_or_create  #=> returns serialized object
    key = ['tonight', Date.today.to_s].join(':')

    if $redis.sismember('tonight:set', key)  # check if in cache
      @tonight = $redis.hgetall(key)
    else  # or create
      @tonight = Tonight.new.attributes
      $redis.multi do |redis|
        redis.mapped_hmset(key, @tonight)
        redis.sadd('tonight:set', key)  # allows search if a particular key is in set -- Redis is BYO indexes
        redis.lpush('tonight:index', key)  # allows search by range - archive is stack, push on left
      end
    end

    return @tonight  # TODO: build from hash here
  end


  def inspect
    "#<Tonight:#{permalink}>"
  end

  def attributes
    Hash[
      date: date,
      title: title,
      summary: summary,
      img_url: img_url,
      permalink: permalink
    ].with_indifferent_access
  end


  # `x || y ` => only parse the document once and cache the result on the instance
  def cache
    @cache || @doc.to_s
  end

  def date  # pull date from page
    month = @doc.css('li.Tonight > .date_icon > span').text
    day = @doc.css('li.Tonight > .date_icon > em').text
    @date || [Date.today.year, month, day].join('-')
  end

  def title
    @title || @doc.css('.entry-title')[0].text.strip
  end

  def summary
    bottom_line = @doc.css('.entry > p').find do |node|  # find <p> starting w/ "Bottom line:"
      node.text =~ /\ABottom line:/i
    end

    text = bottom_line.try(:text)  # TODO: alternate summary if no "bottom line"
    @summary || text.sub(/\ABottom line: /i, '').strip if text # slice out "Bottom line:" from summary
  end

  def img_url
    @img_url || @doc.css('.tonight_image > img')[0]['src']
  end

  def permalink
    @permalink || @doc.css('li.Tonight > a')[0]['href'].prepend('http://earthsky.org')
  end

private
  def scrape
    tries = 0

    begin
      tries += 1

      response = Faraday.get 'http://earthsky.org/tonight'
      @doc = Nokogiri::HTML(response.body)  # parse DOM to tree structure

    rescue Faraday::ConnectionFailed => error
      puts error.message

      sleep(0.5); retry if tries < 5  # try a few times for a response, then give up
      raise
    end
  end

end
