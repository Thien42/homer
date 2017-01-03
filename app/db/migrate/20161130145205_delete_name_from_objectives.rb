class DeleteNameFromObjectives < ActiveRecord::Migration[5.0]
  def change
    remove_column :objectives, :name
  end
end
