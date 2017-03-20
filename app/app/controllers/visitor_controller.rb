class VisitorController < ActionController::Base
  # GET /visitor
  # GET /visitor.json
  def index
    @projects = Project.order(:name)
  end

  # GET /visitor/1
  # GET /visitor/1.json
  def show
    @project = Project.find(params[:id])
    
    respond_to do |format|
      format.html { render :show }
      format.pdf {
        render :pdf => 'show', :layout => 'application.pdf'
      }
    end
  end

end
