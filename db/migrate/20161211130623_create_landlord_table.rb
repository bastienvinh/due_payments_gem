class CreateLandlordTable < ActiveRecord::Migration[5.0]

  def up
    create_table :landlords do |t|
      t.string :firstname, :null => false
      t.string :lastname, :null => false
      t.string :address, :null => false
      t.string :zip_code, :limit => 9, :null => false
      t.string :phone_number, :limit => 15
      t.string :email, :null => false
      t.string :phone_number, :limit => 12, :nil => true
      t.boolean :enable, :default => true, :null => false

      t.timestamps
    end
  end

  def down
    drop_table :landlords
  end

end
