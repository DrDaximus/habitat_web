module ProjectsHelper

	def generate_project_reference
		"HAB" + Time.now.strftime("%m%S%L")
	end

	  # Used on project creation to detrmin who added job.
  def added_by_who
  	unless current_user.admin?
  		"Customer"
 		else
 			current_user.name
 		end 	
  end

  def test_handler(handler)
  	handler ? handler : "TBC"
  end	
  def test_quote(quote)
  	quote ? to_cur(quote) : "TBC" 
  end
  def test_team(team)
  	team ? team.team_name : "TBC" 
  end
  def test_start(start)
  	start ? start.strftime("%a %-d %b %Y") : "TBC" 
  end

  def project_icon(stage)
  		case stage
  		when 1
  			"icon-note"
  		when 2
  			"icon-calculator"
  		when 3
  			"icon-calendar"
  		when 4
  			"icon-rocket"
  		when 5
  			"icon-check"
  		end
  end

  def days_ago(date)
  	pluralize(Date.today.day - date.day, "day")
  end

  def budget(budget)
		case budget
		when 5
			(options_for_budget[0])[0]
		when 4
			(options_for_budget[1])[0]
		when 3
			(options_for_budget[2])[0]
		when 2
			(options_for_budget[3])[0]
		when 1
			(options_for_budget[4])[0]
		when 0
			(options_for_budget[5])[0]
		end
	end	

	def idealwhen(ideal)
		case ideal
		when 5
			(options_for_when[0])[0]
		when 4
			(options_for_when[1])[0]
		when 3
			(options_for_when[2])[0]
		when 2
			(options_for_when[3])[0]
		when 1
			(options_for_when[4])[0]
		end
	end	

end
