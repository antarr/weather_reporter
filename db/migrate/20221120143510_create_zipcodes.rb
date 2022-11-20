class CreateZipcodes < ActiveRecord::Migration[6.1]
  def change
    create_table :zipcodes, id: false, primary_key: :zip do |t|
      t.string :zip
      t.string :lat
      t.string :lng
    end
    add_index :zipcodes, :zip, unique: true
  end
end
