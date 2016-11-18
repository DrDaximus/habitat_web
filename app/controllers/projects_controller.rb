class ProjectsController < ApplicationController
  before_filter :authorise
  before_filter :must_be_admin, except: [:new, :create, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :send_email]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @quoting = Project.where(["stage = ?", 2])
    @enq = Project.where(["stage = ?", 1])
    @quoting_hash = Gmaps4rails.build_markers(@quoting) do |project, marker|
      marker.lat project.latitude
      marker.lng project.longitude
      marker.picture({
        "url" => ActionController::Base.helpers.asset_path('quote_marker.png'),
        "width" => 22,
        "height" => 36
        })
    end 
    @enq_hash = Gmaps4rails.build_markers(@enq) do |project, marker|
      marker.lat project.latitude
      marker.lng project.longitude
      marker.picture({
        "url" => ActionController::Base.helpers.asset_path('enq_marker.png'),
        "width" => 22,
        "height" => 36
        })
    end 
    
  end

  def search
    @project = Project.where(["reference = ?", params[:search]]).first
    if @project
      redirect_to project_path(@project.id)
    else
      redirect_to :back, alert: "No project found with that reference!"
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @user = User.find(@project.user_id) if @project.user_id
  end

  # GET /projects/new
  def new
    @user = current_user
    @project = Project.new(:added_by [@user.role])
    
    #@project = Project.new(user_id: params[:user_id], email: params[:email], added_by: params[:added_by])
  end

  # GET /projects/1/edit
  def edit
    @handlers = User.where(["role = ?", 0])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        session[:project_id] = @project.id
        send_email
        unless current_user.guest?
          format.html { redirect_to @project, notice: 'Project was successfully created.' } 
          format.json { render :show, status: :created, location: @project }
        else
          @user = current_user
          format.html { redirect_to @user } 
        end
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        check_stage
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def send_invite
    @project = Project.find(params[:id])
    if @project.email?
      CustomerLink.admin_invite(@project).deliver_now
      redirect_to @project, notice: "Invite Sent"
    else
      redirect_to @project, notice: "No Email Address Available!!!" 
    end
  end

  private

    def check_stage
      if @project.complete?
        @stage = 5
        @project.update_stage(@stage)
      elsif @project.start_date && Date.today > @project.start_date
        @stage = 4
        @project.update_stage(@stage)
      elsif @project.start_date
        @stage = 3
        @project.update_stage(@stage)
      elsif @project.handled
        @stage = 2
        @project.update_stage(@stage)
      else
        @project.update_stage(1)
      end
    end

    def send_email
      if current_user.customer?
        @user = User.find(@project.user_id)
        CustomerLink.existing_customer_new_project(@project, @user).deliver_now
      elsif current_user.admin?
        if @project.email?
          CustomerLink.admin_invite(@project).deliver_now
        end
      else
        CustomerLink.link_email(@project).deliver_now
      end
    end 

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:reference, :added_by, :job_type, :stage, :quote, :start_date, :team_id, :pif, :contract, :handled, :q_sent, :user_id, :email, :first_name, :last_name, :telephone, :post_code, :budget, :when, :design, :notes, :complete, :deposit, :longitude, :latitude)
    end

    def must_be_admin
      unless current_user && current_user.admin?
        if current_user
          redirect_to user_path(current_user), notice: "Not Authorised"
        else
          redirect_to signin_url, notice: "Not Authorised"
        end
      end
    end
    
end
