class ProjectsController < ApplicationController
  before_filter :authorise
  before_filter :must_be_admin, except: [:new, :create, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new(reference: params[:reference], customer_id: params[:customer_id])
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        
        if @project.email?
         CustomerLink.link_email(@project).deliver_now
        end
        if @project.customer_id?
          @customer = Customer.find(@project.customer_id)
          CustomerLink.existing_customer_new_project(@project, @customer).deliver_now
        end

        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:reference, :added_by, :job_type, :stage, :quote, :start_date, :team, :pif, :contract, :handled, :q_sent, :customer_id, :email)
    end

    def must_be_admin
      unless current_customer && current_customer.id == 999
        if current_customer
          redirect_to customer_path(current_customer), notice: "Not Authorised"
        else
          redirect_to signin_url, notice: "Not Authorised"
        end
      end
    end
    
end
