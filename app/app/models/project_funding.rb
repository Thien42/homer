class ProjectFunding < ApplicationRecord
  belongs_to :project
  belongs_to :user

  def get_status_name
    if self.status == 0
      return "Projet en cours"
    elsif status == 1
      return "Projet terminé"
    end
  end
end
