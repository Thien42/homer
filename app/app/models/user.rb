class User < ApplicationRecord
  has_many :projects
  has_many :project_fundings
  has_many :objective_validations

  validates_format_of :email, :with => /\A\S+\.\S+\b@epitech.eu\b/

  def spices
    @spices = 60
    @fundings = self.project_fundings

    if !@fundings.nil?
      @fundings.each do |funding|
        if funding.status == 0
          @spices -= funding.spices
        elsif funding.status == 1 || funding.status == 2
          @spices += funding.spices
        end
      end
    end
    @spices
  end

  def is_funding_project(project_id)
    @project = Project.find_by_id(project_id)

    if @project.nil?
      return false
    else
      @project.project_fundings.each do |f|
        if f.user.id == self.id
          return true
        end
      end
      return false
    end
  end

  def is_present(project, type)
    @objective = Objective.where({project_id: project.id, objective_type: type}).take
    @validation = ObjectiveValidation.where({user_id: self.id, objective_id: @objective.id}).take
    if @validation
      return true
    else
      return false
    end
  end
end
