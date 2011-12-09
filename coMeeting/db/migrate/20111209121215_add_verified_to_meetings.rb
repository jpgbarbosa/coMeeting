class AddVerifiedToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :verified, :boolean
  end
end
