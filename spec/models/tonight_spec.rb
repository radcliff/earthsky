require 'spec_helper'

describe Tonight do

  before :all do
    VCR.use_cassette 'model/tonight' do
      @tonight = Tonight.new
    end
  end

  it 'is initialized' do
    expect(@tonight).to respond_to(:cache, :date, :title, :summary, :img_url, :permalink, :attributes)

    attributes = @tonight.try(:attributes)
    expect(attributes).not_to include(:cache)
    expect(attributes).to include(:title, :summary, :img_url, :permalink)
  end

  it 'is built from data scraped from "/tonight"' do    
    attributes = Hash[
      date: "2015-07-30",
      title: "Blue Moon – second July full moon – on July 31",
      summary: "The July 31, 2015 full moon won’t appear blue in color.  But – as the second of two full moons to occur in a single calendar month – many will call it a Blue Moon.",
      img_url: "http://en.es-static.us/upl/2015/07/moon-blue-La-Lune-The-Moon-7-27-2015-Patrick-Casaert-sq-e1438256991732.jpg",
      permalink: "http://earthsky.org/tonight/blue-moon-second-july-full-moon-to-occur-on-july-31" 
    ]

    expect(@tonight).to have_attributes attributes
  end

  describe '#find_or_create' do
    before :each do
      VCR.use_cassette 'model/tonight' do
        @tonite = Tonight.find_or_create
      end

      @key = ['tonight', Date.today.to_s].join(':')
    end

    it 'caches a new "tonight"' do
      expect($redis.exists(@key)).to be(true)
    end

    it 'finds an existing "tonight' do
      tonight = $redis.hgetall(@key)
      tonite = Tonight.find_or_create  # no VCR -> shouldn't make web request here

      expect(tonight).to eq(tonite)
    end
  end

end
