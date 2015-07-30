require 'spec_helper'

describe Api::V1::TonightController, type: :controller do
  render_views

  describe 'GET #show' do

    before do 
      get :show, format: :json
    end

    it 'returns a "tonight" post object' do
      VCR.use_cassette 'model/tonight' do
        @tonight = FactoryGirl.build(:tonight)
      end

      expect(response).to be_success
      expect(response).to have_http_status(200)

      tonight = JSON.parse(response.body)["data"]
      expect(tonight).to eq(@tonight.attributes)
    end 

    it "renders the :show view" do
      expect(response).to render_template('api/v1/tonight/show')
    end

  end

end
