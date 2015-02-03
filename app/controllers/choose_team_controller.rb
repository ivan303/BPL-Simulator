class ChooseTeamController < ApplicationController
	
	expose(:club)
	expose(:clubs)

	def show
	end

	def create
		selected = false
		Club.all.each do |club|
			if club.chosen 
				selected = true
			end
		end
		#byebug
		if !selected
			@club = Club.find(params[:clubs][:id])
			@club.update(chosen: true)

			@info = SeasonInfo.first
			@info.update(club_name: @club[:name], round: 1)

			#render 'team_management/show'
			redirect_to team_management_path
		else
			redirect_to team_management_path
		end
	end
end
