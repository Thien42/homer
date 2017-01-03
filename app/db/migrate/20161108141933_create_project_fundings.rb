class CreateProjectFundings < ActiveRecord::Migration[5.0]
  def change
    create_table :project_fundings do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :spices
      t.string :comment
      t.timestamps
    end
  end
end
