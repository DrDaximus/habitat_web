class CustomerLink < ApplicationMailer

	def link_email(project)
  	@project = project
  	mail(to: @project.email, 
      subject: "Habitat Project Ref: #{@project.reference} - Complete your registration now...")
  end

  def existing_customer_new_project(project, user)
  	@project = project
  	@user = user
  	mail(to: @user.email, 
      subject: "Your New Habitat Project - Ref: #{@project.reference}")
  end

  def admin_invite(project)
  	@project = project
    mail(to: @project.email, 
      subject: "Register a My Habitat Account - Ref: #{@project.reference}")
  end

  def email_contract(project)
    @project = project
    filename = "#{@project.reference}_#{@project.last_name}_Contract.pdf"
    attachments[filename] = ContractPdf.new(@project).render
    mail(to: @project.email,
         cc: "carl@habitatlandscapes.co.uk",
         subject: "Habitat Standard Contract - Ref: #{@project.reference}")
  end


end
