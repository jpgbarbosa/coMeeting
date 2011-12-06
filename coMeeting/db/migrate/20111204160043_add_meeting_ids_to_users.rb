class AddMeetingIdsToUsers < ActiveRecord::Migration
  def change
	remove_column :users, :meeting_ids
    add_column :users, :meeting_ids, :text
  end
end
