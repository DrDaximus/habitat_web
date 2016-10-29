class SessionsController < ApplicationController
  def new
  end

  def create
  	customer = Customer.find_by_email(params[:signin][:email])
  	if customer && customer.authenticate(params[:signin][:password])
  		session[:customer_id] = customer.id
  		redirect_to customer_path(customer.id), notice: "Logged in succesfully"
  	else
  		flash.now.alert = "Email or Password invalid"
  		render "new"
  	end
  end

  def destroy
    session[:customer_id] = nil
    redirect_to root_url
  end

end
