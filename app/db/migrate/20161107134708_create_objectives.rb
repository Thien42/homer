class CreateObjectives < ActiveRecord::Migration[5.0]
  def change
    create_table :objectives do |t|
      t.string :name
      t.date :date
      t.integer :status

      t.timestamps
    end
  end
end
