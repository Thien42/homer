class AuthController < ApplicationController
  include AuthHelper

  def gettoken    
    token = get_token_from_code params[:code]
    session[:azure_token] = token.to_hash
    session[:user_email] = get_user_email token.token
    redirect_to "http://www.zappyrank.eu:3000/user_id/" + session[:user_email]
    session[:azure_token] = nil
    session[:user_email] = nil
    return
    @user = User.find_by_email(session[:user_email])
    if @user.nil?
      @user = User.new
      @user.email = session[:user_email]
      @user.role = 0
      @user.save
    end
    redirect_to root_path
  end

  def login
  end

  def logout
    session[:azure_token] = nil
    session[:user_email] = nil
    redirect_to auth_login_path
  end
end
