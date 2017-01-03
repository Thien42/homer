class DeleteRedactorAssets < ActiveRecord::Migration[5.0]
  def change
    drop_table :redactor_assets
  end
end
