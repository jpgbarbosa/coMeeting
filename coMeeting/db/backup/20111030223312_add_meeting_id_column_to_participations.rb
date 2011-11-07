class AddMeetingIdColumnToParticipations < ActiveRecord::Migration
  def change
    add_column :meetings, :meeting_id, :integer
  end
end
