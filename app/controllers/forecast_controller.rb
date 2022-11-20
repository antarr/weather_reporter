class ForecastController < ApplicationController
  def index
  end

  def search
    @zip_code = Zipcode.find_by(zip: search_params[:zip_code])

    render json: @zip_code, serializer: ZipcodeSerializer, status: :ok
  end

private

  def search_params
    params.permit(:authenticity_token, :zip_code)
  end
end
