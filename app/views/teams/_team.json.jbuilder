json.extract! team, :id, :team_name, :team_no, :team_leader, :created_at, :updated_at
json.url team_url(team, format: :json)