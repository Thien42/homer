class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user, :except => [:login, :gettoken]
  helper_method :user_logged_in, :current_user, :money_name, :advisor_activate, :advisor_spice, :investisor_spice

  def current_user
    session[:user_email] = "fl.vuil@epitech.eu"

    current_user = User.find_by_email(session[:user_email])
    if current_user.nil?
      current_user = User.new
      current_user.email = session[:user_email]
      current_user.role = 0
      current_user.save
    end

    if session[:user_email]
      current_user = User.find_by_email(session[:user_email])
    else
      redirect_to auth_login_path
    end
  end

  def user_logged_in
    if session[:user_email] && session[:azure_token]
      return true
    else
      return false
    end
  end

  '''
    Return name of money set in database
  '''
  def money_name
    Setting.get_money_name
  end

  '''
    Return if advisor activate or no
  '''
  def advisor_activate
    Setting.get_advisors_activates
  end

  '''
    return advisor spice
  '''
  def advisor_spice
    Setting.get_nb_spices_advisors
  end

  '''
    Return investisor spice
  '''
  def investisor_spice
    Setting.get_nb_spices_supporter
  end
end
