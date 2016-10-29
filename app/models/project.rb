class Project < ActiveRecord::Base

	belongs_to :customer # Only if customer registers their account. 

	# Only if an email address is present when a new enquiry is generated, check if that email already exists in the customer database.
	validate :check_existing_customer, if: :email?, on: :create

	# If there is a customer_id present on creation of a new project, it implies that an eamil already exists and has not been enetered, so is not required for validation
	validates :email, presence: true, unless: :customer_id?, on: :create

	# When customer creates an acc, update project with id.
	def update_customer_id(project, id)
		project.update_attributes(:customer_id => id)
	end

	# Check to see if the email address entered for a new enquiry already exists in the customer database.
	def check_existing_customer
		@customer = Customer.where(["email = ?", self.email]).first
		@email = self.email
		if @email == @customer.try(:email)
			errors.add(:email, "- It appears you already have a 'My Habitat' account")
		end
	end

end
