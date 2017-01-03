class StatsController < ApplicationController
  respond_to :html

  before_action :check_user_role

  def check_user_role
    if current_user.role != 1
      render :nothing => true, :status => :forbidden
    end
  end

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

  def index
    @projects = Project.all
  end

  def absent
    @objective = Objective.find(params[:id])
    @missing = @objective.get_missing_users
  end
end
