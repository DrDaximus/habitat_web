class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_customer
  	@current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end
  helper_method :current_customer

  def authorise
  	redirect_to signin_url, alert: "Not Authorised" if current_customer.nil?
  end
end
