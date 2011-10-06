class RemoveTopicsFromMeetings < ActiveRecord::Migration
  def up
    remove_column :meetings, :topics
  end

  def down
    add_column :meetings, :topics, :binary
  end
end
