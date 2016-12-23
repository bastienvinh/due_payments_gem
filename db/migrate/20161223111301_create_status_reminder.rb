class CreateStatusReminder < ActiveRecord::Migration[5.0]

  def up
    # We need to define our own id and remove auto-increment, because the status will always be fix
    create_table :status_reminder, :id => false do |tdef|
      tdef.integer "status_id", :index => true, :options => 'PRIMARY KEY' # remove auto-increment
      tdef.string "name"
    end
  end

  def down
    drop_table :status_reminder
  end

end
