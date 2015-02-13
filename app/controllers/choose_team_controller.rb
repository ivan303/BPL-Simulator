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

			# need to import this two tables because of modifications during simulation
			#ApplicationController.helpers.import_players_from_csv
			#ApplicationController.helpers.import_stadions_from_csv

			#render 'team_management/show'
			redirect_to team_management_path
		else
			flash[:error] = 'Season in progress. End simulation to select new team and start new season.'
			redirect_to team_management_path
		end
	end

	def destroy
   		# all operations to end current simulation and start the new one; cleaning db

   		# all chosen column in clubs - false

   		#byebug
   		# Club.all.each do |c|
   		# 	c.update(chosen: false)
   		# 	c.update(points: 0, goals_scored: 0, goals_lost: 0)
   		# end
   		Club.delete_all
   		ApplicationController.helpers.import_clubs_from_csv
   		ApplicationController.helpers.update_clubs_stats

   		# cleaning SeasonInfo record
   		SeasonInfo.first.update(round: 1, club_name: nil)

   		# cleaning match table
   		Match.all.each { |m| m.delete }

   		# cleaning player table e.g. injury
   		#Player.where(injury: true).each { |p| p.update(injury: false) }
   		
   		# Commented to improve transition to new simulation
   		#Player.delete_all
   		#ApplicationController.helpers.import_players_from_csv
   		#ApplicationController.helpers.update_players_costs

   		# cleaning scorer table 
   		Scorer.delete_all

   		# cleaning transfer table
   		Transfer.delete_all

   		redirect_to choose_team_path, notice: 'Simulation succesfuly ended. You can start the new one'


	end
end
