class Tonight
  attr_reader :cache, :title, :summary, :img_url, :permalink

  def initialize
    scrape  # grab page from earthsky/tonight

    @cache = cache  # html

    @img_url = img_url
    @title = title
    @summary = summary
    @permalink = permalink
  end

  def inspect
    "#<Tonight:#{permalink}>"
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
    response = Faraday.get 'http://earthsky.org/tonight'
    @doc = Nokogiri::HTML(response.body)
  end

end
