class AddObjectivesToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :objectives, :project, foreign_key: true
  end
end
