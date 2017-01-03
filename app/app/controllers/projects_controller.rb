class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :send_spices, :set_status, :objective_validation, :set_objective_status, :assign_spices, :assign_spices_to_user]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.pdf {
        render :pdf => 'show', :layout => 'application.pdf'
      }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.objectives << Objective.new({objective_type: 0})
    @project.objectives << Objective.new({objective_type: 1})
    @project.objectives << Objective.new({objective_type: 2})
  end

  # GET /projects/1/edit
  def edit
    while @project.objectives.size < 3
      @project.objectives << Objective.new
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.status = 0
#    @project.activities.create(project_params[:activities_attributes])
#    @project.objectives.create(project_params[:objectives_attributes])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, :flash => {success: 'Projet créé avec succès'} }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_spices
    @spices = params[:project][:spices].to_i

    # Check user is not funding itself
    if @project.user != current_user
      # Check spices number is correct
      if @spices == 5 || @spices == 15
        # Check the project is fundable and user has enough spices

        @end_spices = @project.get_funded_spices + @spices
        if current_user.spices >= @spices && @end_spices <= @project.spices

          # Check user has not funded this project already
          @fundings = ProjectFunding.where(user: current_user)
          @fundings.each do |f|
            if f.project == @project
              redirect_to @project, :flash => { error: "Vous avez déja donné des épices à ce projet" }
              return
            end
          end

          # Create funding
          @funding = ProjectFunding.new(user: current_user, project: @project, spices: @spices, comment: params[:project][:name])
          if @funding.save

            # Check if project is fully funded
            if @end_spices == @project.spices
              @project.kick_off_validated!
              @project.save
            end
            redirect_to root_path, :flash => { success: "Vous avez donné des épices à ce projet" }
          end
        end
      end
    end
  end

  def set_status
    if current_user.role == 1
      @status = params[:status].to_i

      @project.status = @status
      if @status == 3
        if @project.get_funded_spices != @project.spices
          #  When we end the kick-off and there is not enough spices given
          # The project is reset to its former state
          @project.status = 1
          @project.project_fundings.each do |p|
            p.destroy
          end
        end
      elsif @status == 5 || @status == 7 || @status == 9
        # Check 80% of stats validated the objective
        @objective = Objective.where({project_id: @project.id, objective_type: @project.get_objective_type}).take
        @stats = @objective.get_valid_objectives.to_f / @objective.get_total_supports.to_f

        # Objective is passed if more than 80% of supported validated the completion
        if @stats >= 0.8
          @objective.passed = true
          @objective.save

          # if the delivery is validated we send spices to the supporters and advisors
          if @status == 9
            @project.project_fundings.each do |p|
              p.status = 1
              p.save
            end
          end
        else
          @project.status = @status - 2
          @objective.objective_validations.destroy_all
        end
      end

      if @project.save
        redirect_to root_path
      else
        redirect_to @project, :flash => { error: 'Erreur lors de la mise à jour du projet' }
      end
    else
      render :nothing =>  true, :status => :forbidden
    end
  end

  def set_objective_status
    # Check if the user has voted already or not
    @test = ObjectiveValidation.where({user_id: current_user.id, objective_id: params[:objective_id]}).take
    if @test.nil?
      @objective = Objective.find(params[:objective_id])
      @objective_validation = ObjectiveValidation.new
      @objective_validation.objective = @objective
      @objective_validation.user = current_user
      @objective_validation.passed = params[:passed]
      @objective_validation.save

      redirect_to objective_validation_project_path(@project)
    else
      redirect_to objective_validation_project_path(@project), :flash => { error: 'Vous avez déjà donné votre avis sur cet objectif' }
    end
  end

  def objective_validation
    if !current_user.is_funding_project(@project.id) && current_user.role == 0
      render nothing: true, status: :forbidden
    elsif @project.follow_up_1_started?
      @objective = Objective.where({project_id: @project.id, objective_type: 0}).take
    elsif @project.follow_up_2_started?
      @objective = Objective.where({project_id: @project.id, objective_type: 1}).take
    elsif @project.delivery_started?
      @objective = Objective.where({project_id: @project.id, objective_type: 2}).take
    end
    @stats = @objective.get_valid_objectives.to_f / @objective.get_total_supports
    if @stats.nan?
      @stats = 0
    else
      @stats *= 100
      @stats = @stats.to_i
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if current_user == @project.user
      respond_to do |format|
        if @project.update(project_params)
          format.html { redirect_to @project, :flash => { success: 'Projet correctement mis à jour' } }
          format.json { render :show, status: :ok, location: @project }
        else
          format.html { render :edit }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    if current_user == @project.user || current_user.role == 1
      @project.objectives.each do |obj|
        obj.objective_validations.destroy_all
        obj.destroy
      end
      @project.destroy
      respond_to do |format|
        format.html { redirect_to projects_url, :flash => { success: 'Projet supprimé avec succès' } }
        format.json { head :no_content }
      end
    end
  end

  def assign_spices
  end

  def assign_spices_to_user
    if current_user.role == 1 && @project.delivery_validated?
      @user = User.find_by_email(params[:project][:user])
      @max_spices = @project.spices - @project.assigned_spices

      if params[:project][:spices].to_i <= @max_spices && !@user.nil?
        @funding = ProjectFunding.new
        @funding.spices = params[:project][:spices]
        @funding.user = @user
        @funding.project = @project
        @funding.status = 2
        if @funding.save
          redirect_to root_path, :flash => {success: 'épices correctement assignés'}
        else
          redirect_to  assign_spices_project_path(@project), :flash => {error: "Une erreur s'est produite" }
        end
      else
        redirect_to  assign_spices_project_path(@project), :flash => {error: "Une erreur s'est produite, vérifiez que le nombre d'épices et est correct et que l'utilisateur existe"}
      end
    else
      render :nothing => true, :status => :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :spices, :comment, :status, :passed, :user, objectives_attributes: [:id, :name, :date, :description, :_destroy])
    end
end
