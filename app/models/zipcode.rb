# == Schema Information
#
# Table name: zipcodes
#
#  lat :string
#  lng :string
#  zip :string
#
# Indexes
#
#  index_zipcodes_on_zip  (zip) UNIQUE
#

class Zipcode < ApplicationRecord
  API_URL = 'https://api.open-meteo.com/v1/forecast'.freeze
  validates :zip, presence: true, uniqueness: true

  default_scope { order(zip: :asc) }

  def current_temperture
    current_weather['temperature_2m']
  end

  def min_temp
    forecast['daily']['temperature_2m_min'].first
  end

  def max_temp
    forecast['daily']['temperature_2m_max'].first
  end

  def forecast_cached?
    Rails.cache.exist?("forecast/#{zip}")
  end

private

  def forecast
    Rails.cache.fetch("forecast/#{zip}", expires_in: 30.minutes) do
      request_url = API_URL + "?latitude=#{lat}&longitude=#{lng}&current_weather=true&temperature_unit=fahrenheit&daily[]=temperature_2m_max&daily[]=temperature_2m_min&timezone=CST"
      request = HTTParty.get(request_url)
      JSON.parse(request.body)
    end
  end

  def current_weather
    forecast['current_weather']
  end
end
