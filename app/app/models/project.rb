class Project < ApplicationRecord
  has_many :objectives, inverse_of: :project
  accepts_nested_attributes_for :objectives, reject_if: :all_blank, allow_destroy: true

  belongs_to :user

  has_many :project_fundings

  validates_presence_of :name, :spices, :description

  enum status:
  {
      pending:                0,    # Created but not confirmed by admin
      confirmed_by_admin:     1,    # Confirmed by admin user
      kick_off_start:         2,    # Kick-off started : users can send spices
      kick_off_validated:     3,    # Kick-off validated : waiting for follow-up
      follow_up_1_started:    4,    # Follow-up 1 started : users can vote for objective to be completed
      follow_up_1_validated:  5,
      follow_up_2_started:    6,
      follow_up_2_validated:  7,
      delivery_started:       8,
      delivery_validated:     9
  }

  def get_funded_spices
    if Project.statuses[self.status] >= 3
      # Project already funded, no need to check
      return self.spices
    else
      @spices = 0 
      self.project_fundings.each do |s|
        if s.status == 0
          @spices += s.spices
        end
      end
      @spices
    end
  end

  def get_objective_type
    if self.follow_up_1_started? || self.follow_up_1_validated?
      return 0
    elsif self.follow_up_2_started? || self.follow_up_2_validated?
      return 1
    elsif self.delivery_started? || self.delivery_validated?
      return 2
    end
  end

  def assigned_spices
    @spices = ProjectFunding.where({project_id: self.id, status: 2})
    @ret = 0
    @spices.each do |s|
      @ret += s.spices
    end
    @ret
  end

  def get_status
    if self.pending?
      return "En attente de validation par un pédago"
    elsif self.confirmed_by_admin?
      return "En attente de kick-off"
    elsif self.kick_off_start?
      return "Kick-off en cours"
    elsif self.kick_off_validated?
      return "Kick-off validé"
    elsif self.follow_up_1_started?
      return "Follow-up 1 en cours"
    elsif self.follow_up_1_validated?
      return "Follow-up 1 validé"
    elsif self.follow_up_2_started?
      return "Follow-up 2 en cours"
    elsif self.follow_up_2_validated?
      return "Follow-up 2 validé"
    elsif self.delivery_started?
      return "Delivery en cours"
    elsif self.delivery_validated?
      return "Projet terminé"
    end
  end

  def get_status_action
    if self.pending?
      return "Valider le projet"
    elsif self.confirmed_by_admin?
      return "Démarrer le kick-off"
    elsif self.kick_off_start?
      return "Terminer le kick-off"
    elsif self.kick_off_validated?
      return "Démarrer le follow-up 1"
    elsif self.follow_up_1_started?
      return "Terminer le follow-up 1"
    elsif self.follow_up_1_validated?
      return "Démarrer le follow-up 2"
    elsif self.follow_up_2_started?
      return "Terminer le follow-up 2"
    elsif self.follow_up_2_validated?
      return "Démarrer le delivery"
    elsif self.delivery_started?
      return "Terminer le delivery"
    end
  end
end
