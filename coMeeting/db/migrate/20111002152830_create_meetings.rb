class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :subject
      t.datetime :date
      t.string :local
      t.string :admin
      t.string :link_admin

      t.binary :topics
      t.string :proceedings

      t.timestamps
    end
  end
end
