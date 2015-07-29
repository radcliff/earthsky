require 'spec_helper'

describe Tonight do

  before :all do
    VCR.use_cassette 'model/tonight' do
      @tonight = Tonight.new
    end
  end

  it 'is initialized' do
    expect(@tonight).to respond_to(:cache, :title, :summary, :img_url, :permalink, :attributes)

    attributes = @tonight.try(:attributes)
    expect(attributes).not_to include(:cache)
    expect(attributes).to include(:title, :summary, :img_url, :permalink)
  end

  it 'is built from data scraped from "/tonight"' do    
    attributes = Hash[
      title: "Orion the Hunter: Ghost of summer dawn",
      summary: "In the wee hours before daybreak, look for Orion the Hunter: Ghost of the summer dawn.",
      img_url: "http://en.es-static.us/upl/2010/07/10jul31_430.jpg",
      permalink: "http://earthsky.org/tonight/orion-the-hunter-ghost-of-the-summer-dawn" 
    ]

    expect(@tonight).to have_attributes attributes
  end

end
