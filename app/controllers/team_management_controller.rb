class TeamManagementController < ApplicationController
	def show
		Club.all.each do |c|
			if c.chosen
				@chosenClub = c
			end
		end
	end	
end
