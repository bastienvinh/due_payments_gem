class CreateTableLastUpdated < ActiveRecord::Migration[5.0]

  def up
    create_table :last_periods_estates, :id => false do |tdef|
      tdef.integer "estates_id"
      tdef.datetime "last_updated"
    end
  end

  def down
    drop_table :last_periods_estates
  end

end
