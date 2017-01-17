class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user, :except => [:login, :gettoken]
  helper_method :user_logged_in, :current_user

  def current_user
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
