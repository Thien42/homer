class VisitorController < ActionController::Base
  # GET /visitor
  # GET /visitor.json
  def index
    @projects = Project.where.not({status: 0}).order(:name)
  end

  # GET /visitor/1
  # GET /visitor/1.json
  def show
    @project = Project.find(params[:id])

    @number_of_project = Project.where({name: @project.name}).size
    respond_to do |format|
      format.html { render :show }
      format.pdf {
        render :pdf => 'show', :layout => 'application.pdf'
      }
    end
  end

  # GET /projects/:id/historic
  def historic
    @project = Project.find(params[:id])
    @projects = Project.where({name: @project.name}).order('created_at desc')
    render :historic
  end


end
