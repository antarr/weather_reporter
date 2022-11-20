require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  let(:zipcode) { create(:zipcode) }

  describe "GET /index" do
    it "returns http success" do
      get "/forecast/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /index" do
    it "returns the current forcast" do
      zip = zipcode.zip
      VCR.use_cassette("request_post_forecast") do
        post "/forecast/index", params: {zip_code: zip}
        expect(response.body).to include("The forecast in #{zip} calls for")
      end
    end
  end
end
