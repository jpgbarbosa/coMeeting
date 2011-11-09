class ChangeDurationColumnInMeetings < ActiveRecord::Migration
  def change
    change_column :meetings, :duration, :timestamp
  end
end
