class CreatePeriods < ActiveRecord::Migration[5.0]

  def up
    create_table :periods do |tdef|
      tdef.string :name, :null => false # not sure if I should put an index here
      tdef.integer :number_of_days, :limit => 4
      tdef.boolean :recycle_period, :default => false, :null => false
      tdef.datetime :before_date, :null => true

      tdef.timestamps
    end
  end

  def down
    drop_table :periods
  end

end
