class Tonight
  attr_reader :cache, :title, :summary, :img_url, :permalink

  def initialize
    scrape  # grab page from earthsky/tonight

    @cache = cache  # html

    @title = title
    @summary = summary
    @img_url = img_url
    @permalink = permalink
  end


  def self.find_or_create  #=> returns serialized object
    key = ['tonight', Date.today.to_s].join(':')

    if $redis.exists(key)  # check if in cache
      @tonight = $redis.hgetall(key)
    else  # or create
      @tonight = Tonight.new.attributes
      $redis.mapped_hmset(key, @tonight)
    end

    return @tonight
  end


  def inspect
    "#<Tonight:#{permalink}>"
  end

  def attributes
    Hash[
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

  def title
    @title || @doc.css('.entry-title')[0].text.strip
  end

  def summary
    bottom_line = @doc.css('.entry > p').find do |node|  # find <p> starting w/ "Bottom line:"
      node.text =~ /\ABottom line:/i
    end

    @summary || bottom_line.text.sub(/\ABottom line: /i, '').strip  # slice out "Bottom line:" from summary
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
      @doc = Nokogiri::HTML(response.body)

    rescue Faraday::ConnectionFailed => error
      puts error.message

      sleep(0.5); retry if tries < 5
      raise
    end
  end

end
