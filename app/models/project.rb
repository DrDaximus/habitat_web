class Project < ActiveRecord::Base

	belongs_to :user # Only if customer registers their account.  
	belongs_to :team # Only if customer registers their account.  

	# If no user logged in, check if that email already exists in the customer database.
	validate :check_existing_customer, unless: :user_id?, on: :create

	# If there is a customer_id present on creation of a new project, it implies that an eamil already exists and has not been enetered, so is not required for validation
	validates :email, presence: true, unless: :added_by_admin?, on: :create
	validates :job_type, presence: true

	# When customer creates an acc, update project with id.
	def update_user_id(project, id)
		project.update_attributes(:user_id => id)
	end

	# Check to see if the email address entered for a new enquiry already exists in the customer database.
	def check_existing_customer
			@user = User.where(["email = ?", self.email]).first
			@email = self.email
			if @email == @user.try(:email)
				errors.add(:email, "- It appears you already have a 'My Habitat' account")
			end
	end

	def added_by_admin?
		added_by == "admin"
	end

	def update_stage(stage)
		self.update_attributes(:stage => stage)
	end

end
