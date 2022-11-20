# rubocop:disable Rails/SkipsModelValidations
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'parallel'

file_path = Rails.root.join('db', 'fixtures', 'zipcode_mappings.csv')
csv = File.read(file_path)
zip_mappings = CSV.parse(csv, headers: true)

Zipcode.connection.truncate(Zipcode.table_name)

Parallel.each(zip_mappings, in_threads: 4) do |row|
  next unless Integer(row['zip']) rescue false

  Zipcode.upsert({zip: row[0], lat: row[1], lng: row[2]}, unique_by: :index_zipcodes_on_zip)
end

Rails.logger.info "Loaded #{Zipcode.count} zip codes"

# rubocop:enable Rails/SkipsModelValidations
