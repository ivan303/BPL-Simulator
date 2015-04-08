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

			@info = SeasonInfo.first
			@info.update(club_name: @club[:name], round: 1)

			# need to import this two tables because of modifications during simulation
			#ApplicationController.helpers.import_players_from_csv
			#ApplicationController.helpers.import_stadions_from_csv

			redirect_to team_management_path
		else
			flash[:error] = 'Season in progress. End simulation to select new team and start new season.'
			redirect_to team_management_path
		end
	end

	def destroy
   		# all operations to end current simulation and start the new one; cleaning db

   		# all chosen column in clubs - false

   		Club.delete_all
   		ApplicationController.helpers.import_clubs_from_csv
   		ApplicationController.helpers.update_clubs_stats

   		# cleaning SeasonInfo record
   		SeasonInfo.first.update(round: 1, club_name: nil)

   		# cleaning match table
   		Match.all.each { |m| m.delete }
   		
   		# cleaning scorer table 
   		Scorer.delete_all

   		# cleaning transfer table
   		Transfer.delete_all

   		redirect_to choose_team_path, notice: 'Simulation succesfuly ended. You can start the new one'


	end
end
