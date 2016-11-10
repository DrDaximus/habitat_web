class AddTeamIdToProjects < ActiveRecord::Migration
  def change
  	rename_column :projects, :team, :team_id
  end
end
