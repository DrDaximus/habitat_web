class UsersController < ApplicationController
  before_filter :authorise, except: [:new, :create]
  before_filter :must_be_admin, except: [:new, :create, :edit, :update, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @projects = Project.all
    @aloc_projects = @projects.where(["handled = ?", @user.name])
  end

  # GET /users/new
  def new
    @project = Project.where(["user_id = ?", current_user.id]).first if current_user
    @user = User.new(name: params[:name], lastname: params[:lastname], email: params[:email], reference: params[:reference])
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = params[:user] ? User.new(user_params) : User.new_guest
    respond_to do |format|
      if @user.save
        current_user.move_to(@user) if current_user && current_user.guest?
        session[:user_id] = @user.id
        if @user.guest?
          format.html { redirect_to new_project_path(user_id: current_user.id,added_by: "guest") }
        else
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        end
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      if current_user.customer? && @user.id != current_user.id
        redirect_to root_path, alert: "Not Authorised"
      else
        @user
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :lastname, :email, :password_digest, :reference, :role, :password, :password_confirmation)
    end
end
