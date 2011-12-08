class AddTimezoneToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :timezone, :string
  end
end
