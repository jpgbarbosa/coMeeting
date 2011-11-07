class ChangeIsAttendingTypeInParticipations < ActiveRecord::Migration
  def change
    change_column :participations, :is_attending, :integer
  end
end
