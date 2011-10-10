class AddMeetingTimeToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :meeting_time, :time
  end
end
