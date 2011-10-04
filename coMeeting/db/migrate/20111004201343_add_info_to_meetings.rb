class AddInfoToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :extra_info, :string
  end
end
