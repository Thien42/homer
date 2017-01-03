class AddActivitiesToProject < ActiveRecord::Migration[5.0]
  def change
    add_reference :activities, :project, foreign_key: true
  end
end
