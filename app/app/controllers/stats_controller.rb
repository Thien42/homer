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
end
