class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:signin][:email])
  	if user && user.authenticate(params[:signin][:password])
  		session[:user_id] = user.id
  		redirect_to user_path(user.id), notice: "Logged in succesfully"
  	else
  		flash.now.alert = "Email or Password invalid"
  		render "new"
  	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out successfully"
  end

end
