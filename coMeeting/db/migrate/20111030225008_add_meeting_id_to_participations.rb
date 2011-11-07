class AddMeetingIdToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :meeting_id, :integer
  end
end
