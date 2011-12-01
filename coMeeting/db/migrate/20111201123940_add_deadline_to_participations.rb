class AddDeadlineToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :deadline, :string
  end
end
