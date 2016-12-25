class CreateTableReminders < ActiveRecord::Migration[5.0]

  def up
    create_table :reminders do |tdef|
      tdef.integer "estate_id", :index => true
      tdef.integer "period_id", :index => true
      tdef.datetime "date_to_pay"
      tdef.datetime "date_to_notify"
      tdef.integer "status_id", :nil => true
      tdef.boolean "enable", :null => false, :default => true

      tdef.timestamps
    end
  end

  def down
    drop_table :reminders
  end

end
