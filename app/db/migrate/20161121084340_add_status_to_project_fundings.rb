class AddStatusToProjectFundings < ActiveRecord::Migration[5.0]
  def change
    add_column :project_fundings, :status, :integer, :default =>  0
  end
end
