module UsersHelper

	def registered?
		if @project.user_id?
			true			
		end
	end

	# Alters account invite button depending on who's viewing.
  def invite_button(project, classname)
  	link_to send_invite_project_path(project) do
  		if current_user.admin?
				content_tag(:span, "Send an Invite", class: classname)
			else
				content_tag(:span, "Email me registration details", class: classname)
			end
		end
	end 

	# Following used to determine if job has registered user and either uses guest info on project record, or extracts from user model if one exists.

	def firstname(project, user)
		if project.user_id?
			user.name
		else
			project.first_name
		end
	end

	def lastname(project, user)
		if project.user_id?
			user.lastname
		else
			project.last_name
		end
	end

	def telephone(project, user)
		if project.user_id?
			#Update once user model has teephone number field
			project.telephone
		else
			project.telephone
		end
	end

	def email(project, user)
		if project.user_id?
			user.email
		else
			project.email
		end
	end

end
