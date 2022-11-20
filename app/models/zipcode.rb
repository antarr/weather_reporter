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
    Integer(forecast['current_weather']['temperature'])
  end

  def min_temp
    Integer(forecast['daily']['temperature_2m_min'].first)
  end

  def max_temp
    Integer(forecast['daily']['temperature_2m_max'].first)
  end

  def forecast_cached?
    Rails.cache.exist?("forecast/#{zip}")
  end

  def cached_at
    forecast['current_weather']['time']
  end

  def summary
    "The forecast in #{zip} #{forecast_description} with a high of #{max_temp} and a low of #{min_temp}. The current temperature is #{current_temperture}."
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

  def forecast_description
    case current_weather['weathercode']
    when 0
      'calls for clear skies'
    when 1, 2, 3
      'is mainly clear, but partly cloudy or overcast'
    when 45, 48
      'included fog'
    when 51, 53, 55
      'a light to moderate drizzle'
    when 61, 63, 65
      'a light to moderate rain'
    when 66, 67
      'both light and heave freezing rain'
    when 71, 73, 75
      'a light to moderate snow fall'
    when 77
      'snow grains'
    when 80, 81, 82
      'a light to moderate rain shower'
    when 85, 86
      'a light to moderate snow shower'
    when 95
      'a light to moderate thunderstorm'
    when 96, 99
      'a light to moderate thunderstorm with hail'
    end
  end
end
