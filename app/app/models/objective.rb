class Objective < ApplicationRecord
  belongs_to :project, inverse_of: :objectives
  has_many :objective_validations

  enum objective_type: {
      follow_up_1: 0,
      follow_up_2: 1,
      delivery: 2
  }

  def get_valid_objectives
    ObjectiveValidation.where({:objective_id => self.id, :passed => true}).size
  end

  def get_invalid_objectives
    ObjectiveValidation.where({:objective_id => self.id, :passed => false}).size
  end

  def get_total_objectives
    ObjectiveValidation.where({:objective_id => self.id}).size
  end

  def get_total_supports
    self.project.project_fundings.size
  end

  def get_user_votes
    self.objective_validations.size
  end

  def user_has_voted_objective(user_id)
    ObjectiveValidation.where({objective_id: self.id, user_id: user_id}).take
  end
end
