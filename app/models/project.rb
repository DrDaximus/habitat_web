class Project < ActiveRecord::Base

	belongs_to :user # Only if customer registers their account.  
	belongs_to :team # Only if customer registers their account.  

	has_attached_file :contract

	validates_attachment :contract, content_type: { content_type: 'application/pdf' }

	# If no user logged in, check if that email already exists in the customer database.
	validate :check_existing_customer, unless: :user_id?, on: :create
	validate :check_pc

	# If there is a customer_id present on creation of a new project, it implies that an eamil already exists and has not been enetered, so is not required for validation
	validates :email, :first_name, :last_name, :telephone, :post_code, :job_type, :budget, :when, presence: true, on: :create

	geocoded_by :post_code  
	after_validation :geocode          # auto-fetch coordinates

	scope :contracted, -> { where(contract_present: true) }
	scope :enquiries, -> { where(stage: 1) }
	scope :quoting, -> { where(stage: 2) }
	scope :booked, -> { where(stage: 3) }
	scope :active, -> { where(stage: 4) }
	scope :complete, -> { where(stage: 5) }

	# When customer creates an acc, update project with id.
	def update_user_id(project, id)
		project.update_attributes(:user_id => id)
	end

	def self.update_email(project, email)
		project.update_attributes(:email => email)
	end

	def self.update_contract(project)
		project.update_attributes(:contract_present => true, :contract_date => Time.now)
	end

	def post_code=(str)
  	super UKPostcode.parse(str).to_s
	end

	def check_pc
		unless self.post_code.blank?
			ukpc = UKPostcode.parse(self.post_code)
	    unless ukpc.full_valid?
	    	errors.add(:post_code, "not a valid UK postcode")
	    end
    end
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
