class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.string :money_name, :defauft => "épices"
      t.boolean :advisors_activates, :default => false
      t.integer :nb_spices_advisors, :default => 15
      t.integer :nb_spices_supporter, :default => 5

      t.timestamps
    end
  end
end
