class ChangeNomeInUsers < ActiveRecord::Migration
  def change
	remove_column :users, :nome
	add_column :users, :name, :string
  end
end
