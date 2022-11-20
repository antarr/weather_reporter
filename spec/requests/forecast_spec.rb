require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  let(:zipcode) { create(:zipcode) }

  describe "GET /index" do
    it "returns http success" do
      get "/forecast/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /search" do
    it "returns http success" do
      zip = zipcode.zip
      VCR.use_cassette("request_post_forecast_search") do
        post "/forecast/search", params: {zip_code: zip}
        max_temp = JSON.parse(response.body)["max_temp"]
        expect(max_temp).to eq(-33.6)
      end
    end
  end
end
