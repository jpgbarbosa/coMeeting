class AddDurationTomeetings < ActiveRecord::Migration
  def up
    add_column :meetings, :duration, :datetime
  end

  def down
  end
end
