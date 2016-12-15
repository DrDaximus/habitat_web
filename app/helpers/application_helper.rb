module ApplicationHelper

	def icon_check(condition)
		condition ? "fa-check" : "fa-times"
	end

	# UK currency format
	def to_cur(number)
		number_to_currency(number, :unit => "£")
	end

	def options_for_role
		[
			["admin"],
			["customer"],
			["designer"]
		]
	end

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

	def options_for_budget
		[
			["Up to £5,000", 5],
			["£5,000 - £10,000", 4],
			["£10,000 - £15,000", 3],
			["£15,000 - £20,000", 2],
			["£20,000 +", 1],
			["Just looking for a quote", 0]

		]
	end

	def options_for_when
		[
			["ASAP", 5],
			["within 1 - 3 months", 4],
			["within 3 - 6 months", 3],
			["within 6 - 12 months", 2],
			["Just looking for a quote", 1]
		]
	end

	def job_stage(stage)
		case stage
			when 1
				"Enquiry"
			when 2 
				"Quoting"
			when 3
				"Contract"
			when 4
				"Underway"
			when 5
				"Complete"
		end
	end

	def new_project_links
		if current_user && (current_user.admin? || current_user.designer?)
			link_to '| new project', new_project_path(:added_by => current_user.role)
		elsif current_user && current_user.customer?
			link_to '| new enquiry', new_project_path
			#link_to 'new enquiry', new_project_path(:user_id => current_user.id, :email => current_user.email, :added_by => current_user.role)
		elsif current_user && current_user.guest?
		else
			link_to '| new enquiry', users_path, method: :post
		end
	end

	def upgrade_account_link
		link_to '| sign up to track your enquiry', signup_path
	end

	def user_menu
		if current_user && (current_user.admin? || current_user.designer?)
    	render 'shared/admin_menu_bar'
  	else  
    	render 'shared/customer_menu_bar'
  	end
  end

end
