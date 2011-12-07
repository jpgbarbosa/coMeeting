class ChangeMeetingTimeInMeeting < ActiveRecord::Migration
  def change
    remove_column :meetings, :meeting_time
    add_column :meetings, :meeting_time, :datetime
  end
end
