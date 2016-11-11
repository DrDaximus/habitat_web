class Team < ActiveRecord::Base
	belongs_to :user
	has_many :projects

	validates_presence_of :team_name, :team_no, :user_id
	validates_uniqueness_of :team_name, :team_no
	
end
