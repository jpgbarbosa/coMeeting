class ChangeLinkAdminInMeetings < ActiveRecord::Migration
  def change
	remove_column :meetings, :link_admin
	add_column :meetings, :token, :string
  end
end
