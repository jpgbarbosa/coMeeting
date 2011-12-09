class ChangeAdminInMeetings < ActiveRecord::Migration
  def change
	remove_column :meetings, :admin
	add_column :meetings, :admin, :integer
  end
end
