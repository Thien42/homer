class AddValidationToObjectives < ActiveRecord::Migration[5.0]
  def change
    add_column :objectives, :passed, :bool, :default => false
  end
end
