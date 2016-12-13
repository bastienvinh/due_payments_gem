class CreateEstatesTable < ActiveRecord::Migration[5.0]

  def up
    create_table :estates do |tdef|
      tdef.integer :estate_code
      tdef.string :name
      tdef.integer :landlord_id

      tdef.timestamps
    end
  end

  def down
    drop_table :estates
  end

end
