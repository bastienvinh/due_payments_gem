class CreateEstatesTable < ActiveRecord::Migration[5.0]

  def up
    create_table :estates do |tdef|
      tdef.integer :estate_code
      tdef.string :name
      tdef.integer :landlord_id
      tdef.decimal :price_per_acre, :precision => 20, :scale => 2
      tdef.integer :acre
      tdef.string :zip_code
      tdef.string :address, :nil => true
      tdef.string :geolocalisation, :nil => true
      tdef.string :coordinate_points, :nil => true #Well if you want to create precise coordinate
      tdef.text :description, :nil => true
      tdef.decimal :total_price, :nil => true, :precision => 20, :scale => 2
      tdef.boolean :enable, :nil => false, :default => true

      tdef.timestamps
    end
  end

  def down
    drop_table :estates
  end

end
