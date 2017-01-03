class DeleteSpicesFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :spices
  end
end
