class AddTopicsToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :topics, :text
  end
end
