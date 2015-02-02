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
		if !selected
			@club = Club.find(params[:clubs][:id])
			@club.update(chosen: true)
			render 'choose_team/show'
		else
			render 'choose_team/show'
		end
	end
end
