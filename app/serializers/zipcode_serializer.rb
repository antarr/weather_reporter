class ZipcodeSerializer < ActiveModel::Serializer
  attributes :zip, :lat, :lng, :current_temperture, :min_temp, :max_temp, :cached

  def cached
    object.forecast_cached?
  end
end
