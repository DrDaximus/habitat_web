module ApplicationHelper

	def options_for_job_type
		[
			["Driveway"],
			["Patio"],
			["Decking"],
			["Partial Landscape"],
			["Full Landscape"],
			["Maintenance"],
			["Other"],
		]
	end

	def options_for_job_stage
		[
			["Enquery", 1],
			["Quoting", 2],
			["Contract", 3],
			["Underway", 4],
			["Complete", 5]
		]
	end

	def options_for_team
		[
			["TBC"],
			["Craig's Team", 1],
			["Lee's Team", 2],
			["Team 3", 3]
		]
	end

	def new_project_links
		if current_user && current_user.admin?
			link_to 'New Project', new_project_path(:added_by => current_user.role)
		elsif current_user && current_user.customer?
			link_to 'New Enquiry', new_project_path(:user_id => current_user.id, :email => current_user.email, :added_by => current_user.role)
		elsif current_user && current_user.guest?
			upgrade_account_link
		else
			link_to 'New Enquiry', users_path, method: :post
		end
	end

	def upgrade_account_link
		link_to 'Sign up to track your enquiry', signup_path 
	end

end
