class RemoveMeetingIdFromMeetings < ActiveRecord::Migration
  def up
    remove_column :meetings, :meeting_id
  end

  def down
    add_column :meetings, :meeting_id, :integer
  end
end
