class ProjectsController < ApplicationController
  before_filter :authorise
  before_filter :must_have_access, except: [:new, :create, :show]
  before_action :set_project, only: [:render_contract, :show, :edit, :update, :destroy, :send_email]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.order(stage: :asc, created_at: :desc).all
    @all_projects = @projects
    @projects = @projects.enquiries if params[:enquiries]
    @projects = @projects.quoting if params[:quoting]
    @projects = @projects.booked if params[:booked]
    @projects = @projects.active if params[:active]
    @projects = @projects.complete if params[:complete]

    @pag_projects = @projects.paginate(:page => params[:page], :per_page => 15)
    @hash = Gmaps4rails.build_markers(@pag_projects) do |project, marker|
      marker.lat project.latitude
      marker.lng project.longitude
      marker.picture({
        "url" => ActionController::Base.helpers.asset_path("stage_#{project.stage}_marker.png"),
        "width" => 22,
        "height" => 36,
        })
      marker.title project.first_name + " " + project.last_name + " ("+project.job_type+")"
    end 
  end

  def search
    @ref = "HAB" + params[:search]
    @project = Project.where(["reference = ?", @ref]).first
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
      redirect_to @project, alert: "No Email Address Available!!!" 
    end
  end

  # Generate contract, save attachemnt to model, send contract via email, update contract_present attribute, and confirm.
  def render_contract
    respond_to do |format|
      format.pdf do 
        pdf = ContractPdf.new(@project)
        pdf.render_file("#{@project.reference}_#{@project.last_name}_Contract.pdf")
        pdf_contract = File.open("#{@project.reference}_#{@project.last_name}_Contract.pdf")
        @project.contract = pdf_contract
        #send_data pdf.render, filename: "#{@project.reference}_#{@project.last_name}_Contract.pdf",
                              #type: "application/pdf"
                              #disposition: "inline"
      end
    end
    CustomerLink.email_contract(@project).deliver_now
    Project.update_contract(@project)
    redirect_to @project, notice: "Contract Sent"
  end

  private

  # Check current stage of job by assessing state of exisitng attributes. Called on update.
    def check_stage
      if @project.complete?
      #Project 'Complete' if complete attribute has been ticked.
        @stage = 5
        @project.update_stage(@stage)
      elsif @project.start_date && Date.today > @project.start_date
      #Project 'Active' if start date is greater than today
        @stage = 4 
        @project.update_stage(@stage)
      elsif @project.start_date
      #Project 'Booked' if start_date present
        @stage = 3 
        @project.update_stage(@stage)
      elsif (@project.handled && @project.handled != "") || @project.quote
      #Project 'Quoting' if admin assigned as handler
        @stage = 2 
        @project.update_stage(@stage)
      else
      #Else project is an 'Enquiry'.
        @project.update_stage(1) 
      end
    end

    # Send eamil to customer. Link sent if admin sending invite, or new customer generated project.
    def send_email
      if current_user.customer?
        # if existing user, send notice of new project creation.
        @user = User.find(@project.user_id)
        CustomerLink.existing_customer_new_project(@project, @user).deliver_now
      elsif current_user.admin?
        # If admin created project, send an invite to the email adress added by admin for user signup. Link inc.
        # Check email address exists before attempting to send email.
        if @project.email?
          CustomerLink.admin_invite(@project).deliver_now
        end
      else
        # New customer generated enquiry, send invite email with link.
        CustomerLink.link_email(@project).deliver_now
      end
    end 

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id]) 
      if current_user.customer? && @project.user_id != current_user.id
        redirect_to root_path, alert: "Not Authorised"
      else
        @project
      end
    end
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:reference, :added_by, :job_type, :stage, :quote, :start_date, :team_id, :pif, :contract, :contract_present, :contract_date, :handled, :q_sent, :user_id, :email, :first_name, :last_name, :telephone, :post_code, :budget, :when, :design, :notes, :complete, :deposit, :longitude, :latitude)
    end
    
end
