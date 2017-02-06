class StatsController < ApplicationController
  def user_data
    @users = User.all
    @spices = 0

    @users.each do |u|
      if u.spices > 0
        @spices += u.spices
      end
    end

    render "data"
  end

  def spices
  end

  def project
    @project = Project.find(params[:id])
  end
  
  def admin
    if current_user.role == 1
      @admins = User.where({role: 1})
      @users = User.where({role: 0})
    end
  end

  def change_status
    if current_user.role == 1
      @user = User.find(params[:user_id])
      @user.role = params[:role].to_i
      if @user.save
        redirect_to stats_admin_path
      end
    else
      render :nothing => true, :status => :not_found
    end
  end
end
