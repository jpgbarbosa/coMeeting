class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.string :token
      t.boolean :is_attending

      t.timestamps
    end
  end
end
