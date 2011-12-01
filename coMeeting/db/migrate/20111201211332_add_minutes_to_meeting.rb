class AddMinutesToMeeting < ActiveRecord::Migration
  def change
	remove_column :meetings, :proceedings
    add_column :meetings, :minutes, :text
  end
end
