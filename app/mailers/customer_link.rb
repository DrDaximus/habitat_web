class CustomerLink < ApplicationMailer

	def link_email(project)
    	@project = project
    	mail(to: @project.email, subject: 'Register a My Habitat Account')
  end

  def existing_customer_new_project(project, customer)
    	@project = project
    	@customer = customer
    	mail(to: @customer.email, subject: 'Your New Habitat Project')
  end

end
