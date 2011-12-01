class ChangeIsAttendingTypeInParticipations < ActiveRecord::Migration
  def change
    remove_column :participations, :is_attending
    add_column :participations, :is_attending, :integer
  end
end
