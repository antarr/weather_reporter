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
FactoryBot.define do
  factory :zipcode do
    zip { Faker::Address.zip_code }
    lat { Faker::Address.latitude }
    lng { Faker::Address.latitude }
  end
end
