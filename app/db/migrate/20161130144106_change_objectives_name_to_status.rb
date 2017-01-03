class ChangeObjectivesNameToStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :objectives, :objective_type, :integer

    Objective.find_each do |obj|
      if obj.name == "Follow-Up 1"
        obj.objective_type = 0
      elsif obj.name == "Follow-Up 2"
        obj.objective_type = 1
      elsif obj.name == "Delivery"
        obj.objective_type = 2
      end
      obj.save!
    end
  end
end
