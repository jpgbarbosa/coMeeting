class ChangeDurationColumnInMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :duration
    add_column :meetings, :duration, :timestamp
  end
end
