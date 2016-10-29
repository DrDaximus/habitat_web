module ApplicationHelper

	def options_for_added_by
		[
			["Unknown"],
			["Carl"],
			["Lee"],
			["Sue"],
			["Craig"],
			["Web Enquiry"]
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

end
