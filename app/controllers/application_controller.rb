class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id] && User.exists?(session[:user_id])
  end
  helper_method :current_user

  def authorise
  	redirect_to signin_url, alert: "Not Authorised" if current_user.nil?
  end

  def admin
    @admin = User.where(["role = ?", 0])
  end

  def designer
    @designer = User.where(["role = ?", 3])
  end

  helper_method :admin

  def must_have_access
    unless current_user && (current_user.admin? || current_user.designer?)
      redirect_to root_path, alert: "Admin Only"
    end
  end
  def must_be_admin
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "Admin Only"
    end
  end
end
