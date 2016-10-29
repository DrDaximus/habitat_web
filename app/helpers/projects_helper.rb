module ProjectsHelper

	def generate_project_reference
 
		"HAB" + Time.now.strftime("%m%S%L")

	end

end
