class RemoveDateFromMeetings < ActiveRecord::Migration
  def up
    remove_column :meetings, :date
  end

  def down
    add_column :meetings, :date, :datetime
  end
end
