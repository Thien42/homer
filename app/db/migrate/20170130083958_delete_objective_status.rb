class DeleteObjectiveStatus < ActiveRecord::Migration[5.0]
  def change
    remove_column :objectives, :status
  end
end
