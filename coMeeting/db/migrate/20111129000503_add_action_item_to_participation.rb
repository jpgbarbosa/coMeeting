class AddActionItemToParticipation < ActiveRecord::Migration
  def change
    add_column :participations, :action_item, :string
  end
end
