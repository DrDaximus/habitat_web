class ChangeTeamLeaderName < ActiveRecord::Migration
  def change
  	rename_column :teams, :team_leader, :user_id
  end
end
