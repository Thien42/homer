class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user, :except => [:login, :gettoken]
  helper_method :user_logged_in, :current_user

  def current_user

    session[:user_email] = "florian.vuillemot@epitech.eu"
    session[:azure_token] = "test"
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

end
