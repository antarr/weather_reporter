class ForecastController < ApplicationController
  DEFAULT_ZIP_CODE = 20_001

  def index
    @zip_code = if zip_code_param
                  cookies[:zip_code] = zip_code_param
                  Zipcode.find_by(zip: zip_code_param) if zip_code_param
                else
                  cookies[:zip_code] ||= DEFAULT_ZIP_CODE
                  Zipcode.find_by(zip: browser_cached_zip_code)
                end
  end

private

  def browser_cached_zip_code
    cookies[:zip_code]
  end

  def search_params
    params.permit(:authenticity_token, :zip_code, :commit)
  end

  def zip_code_param
    search_params[:zip_code]
  end
end
