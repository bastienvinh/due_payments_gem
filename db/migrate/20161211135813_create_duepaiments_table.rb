class CreateDuepaimentsTable < ActiveRecord::Migration[5.0]

  def up
    create_table :duepayments do |tdef|
      tdef.integer "estate_id"
      tdef.integer "period_id"
      
      tdef.timestamps
    end
  end

  def down
    drop_table :duepayments
  end

end
