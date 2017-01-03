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

  def get_missing_users
    # Complex raw SQL query
    User.find_by_sql ["SELECT users.id, users.email FROM users INNER JOIN project_fundings ON (users.id = project_fundings.user_id AND project_id = ?) AND users.id NOT IN (SELECT users.id FROM users INNER JOIN objective_validations ON (users.id = objective_validations.user_id AND objective_validations.objective_id = ?))", self.project.id, self.id ]
  end
end
