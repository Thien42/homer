class AddDescriptionToObjectives < ActiveRecord::Migration[5.0]
  def change
    add_column :objectives, :description, :text
  end
end
