class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mail
      t.string :nome

      t.binary :meeting_ids

      t.timestamps
    end
  end
end
