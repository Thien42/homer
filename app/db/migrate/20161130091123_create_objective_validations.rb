class CreateObjectiveValidations < ActiveRecord::Migration[5.0]
  def change
    create_table :objective_validations do |t|
      t.references :objective, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :passed

      t.timestamps
    end
  end
end
