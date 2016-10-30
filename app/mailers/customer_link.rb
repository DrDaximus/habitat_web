class CustomerLink < ApplicationMailer

	def link_email(project)
    	@project = project
    	mail(to: @project.email, subject: "Complete your Habitat registration now...")
  end

  def existing_customer_new_project(project, user)
    	@project = project
    	@user = user
    	mail(to: @user.email, subject: 'Your New Habitat Project')
  end

  def admin_invite(project)
  	@project = project
    mail(to: @project.email, subject: 'Register a My Habitat Account')
  end

end
