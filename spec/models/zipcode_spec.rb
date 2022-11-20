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
require "rails_helper"

RSpec.describe(Zipcode, type: :model) do
  it { is_expected.to(validate_presence_of(:zip)) }

  it 'validates uniqueness of zip' do
    zip1 = create(:zipcode)
    dupliate_zip = build(:zipcode, zip: zip1.zip)
    expect(dupliate_zip).not_to(be_valid)
  end
end
