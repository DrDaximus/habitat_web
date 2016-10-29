class User < ActiveRecord::Base

	has_secure_password

	has_many :projects

	enum role: [:customer, :admin]

	after_initialize :set_default_role, :if => :new_record?

  after_save :update_project
	# When customer creates an account with project ref, update project to associate with the customer using that reference.
	def update_project
		@project = Project.where(["email = ?", self.email]).first
		@project.update_user_id(@project, self.id)
	end
 	
 	def set_default_role
    self.role ||= :customer
  end

end
