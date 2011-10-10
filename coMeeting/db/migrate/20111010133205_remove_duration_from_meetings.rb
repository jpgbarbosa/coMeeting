class RemoveDurationFromMeetings < ActiveRecord::Migration
  def up
    remove_column :meetings, :duration
  end

  def down
    add_column :meetings, :duration, :datetime
  end
end
