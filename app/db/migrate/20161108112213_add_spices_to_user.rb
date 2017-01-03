class AddSpicesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :spices, :integer, :default => 15
  end
end
