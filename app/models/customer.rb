class Customer < ActiveRecord::Base

	has_many :projects

	# Ensure reference code is formatted correctly
	validates :reference, format: {with: /HAB\d\d\d\d\d\d\d/, message: "Code Invalid"}
	# Ensure no duplicate email addresses for accounts.
	validates :email, uniqueness: true

	after_save :update_projects
	# When customer creates an account with project ref, update project to associate with the customer using that reference.
	def update_projects
		@project = Project.where(["reference = ?", self.reference]).first
		@project.update_customer_id(@project, self.id)
	end

end
