class ChangeMeetingIdsInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :meeting_ids
    add_column :users, :circles, :text
  end
end
