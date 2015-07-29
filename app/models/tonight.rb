class Tonight
  attr_reader :cache, :img_url, :title, :preview, :summary, :permalink

  def initialize
    @cache = cache  # html

    @img_url = img_url
    @title = title
    @summary = summary
    @permalink = permalink
  end

  def cache
    response = Faraday.get 'http://earthsky.org/tonight'
    @cache || @doc = Nokogiri::HTML(response.body)
  end

  def img_url
    @img_url || @doc.css('.tonight_image > img')[0]['src']
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

  def permalink
    @permalink || @doc.css('li.Tonight > a')[0]['href'].prepend('http://earthsky.org')
  end

end
