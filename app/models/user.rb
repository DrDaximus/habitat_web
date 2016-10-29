class User < ActiveRecord::Base

	has_secure_password(validations: false)

	has_many :projects

	enum role: [:customer, :admin, :guest]

	after_initialize :set_default_role, :if => :new_record?
	validates_presence_of :email, :password_digest, unless: :guest?
	validates_confirmation_of :password

  after_save :update_project, if: :reference?
	#When customer creates an account with project ref, update project to associate with the customer using that reference.
	def update_project
		@project = Project.where(["reference = ?", self.reference]).first
		@project.update_user_id(@project, self.id)
	end
 	
 	def set_default_role
    self.role ||= :customer
  end

  def self.new_guest
  	new { |u| u.guest = true, u.role ||= :guest }
  end

  def regname
  	role == "guest" ? "Guest" : name
  end

  def move_to(user)
  	projects.update_all(user_id: user.id)
  end

end
