class CreateTableLastUpdated < ActiveRecord::Migration

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
