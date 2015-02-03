class TeamManagementController < ApplicationController
	
	expose(:player)
	expose(:players)
	
	def show
		#byebug
		@info = SeasonInfo.first
		
		@chosenClub = Club.find_by(name: @info.club_name)
	end	

	def simulate
		byebug
	end
end
