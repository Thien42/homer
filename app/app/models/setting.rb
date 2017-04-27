class Setting < ApplicationRecord

  def self.getSetting
    Setting.first
  end

  def self.get_money_name
    if Setting.first.nil?
      "épices"
    else
      Setting.first.money_name
    end
  end

  def self.get_advisors_activates
    if Setting.first.nil?
      false
    else
      Setting.first.advisors_activates
    end
  end

  def self.get_nb_spices_advisors
    if Setting.first.nil?
      10
    else
      Setting.first.nb_spices_advisors
    end
  end

  def self.get_nb_spices_supporter
    if Setting.first.nil?
      5
    else
      Setting.first.nb_spices_supporter
    end
  end
end
