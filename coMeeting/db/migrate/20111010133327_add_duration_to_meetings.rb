class AddDurationToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :duration, :string
  end
end
