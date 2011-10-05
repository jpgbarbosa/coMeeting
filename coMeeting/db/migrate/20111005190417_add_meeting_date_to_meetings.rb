class AddMeetingDateToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :meeting_date, :string
  end
end
