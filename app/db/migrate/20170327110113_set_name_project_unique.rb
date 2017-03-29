class SetNameProjectUnique < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :name, :text, :unique => true
  end
end
