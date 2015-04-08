class SimulationController < ApplicationController
	include SimulationHelper

	def create
		# bedzie tu wywoływana metoda dokonująca symulacji
		# w przypadku poprawnych danych wyrenderuje akcję show
		# w przeciwnym wypadku powróci do okna managera

		@players = params[:players]

		all_players = !@players.keys.any? { |k| @players[k].blank? }
		if all_players
			unique_players = @players.values.uniq.length
			if unique_players == 11
				# check if chosen players doesn't have injury
				without_injury = !@players.values.any? { |id| Player.find(id).injury }
				if without_injury
					# check if goalkeeper on his position
					if Player.find(@players["id_1"]).position == "B"
						simulation @players
						redirect_to simulation_path	
					else
						flash[:error] = "You didn't put goalkeeper on his position"
						redirect_to team_management_path
					end
				else
					flash[:error] = "You choosed at least one player with injury"
					redirect_to team_management_path
				end
			else
				flash[:error] = "You choosed the same player more than ones"
				redirect_to team_management_path
			end
		else
			flash[:error] = "You need to choose all 11 players for the match"
			redirect_to team_management_path
		end

		
		
	end

	def show
		@matches = Match.where(round: SeasonInfo.first[:round] - 1);
		@scorers = {}

		@matches.each do |match|
			@scorers[match[:id]] = {}
			@scorers[match[:id]][match[:host_club_id]] =  []
			s1 = Scorer.where(match_id: match[:id], club_id: match[:host_club_id])
			s1.each do |s|
				@scorers[match[:id]][match[:host_club_id]] << TeamManagementController.helpers.player_name(Player.find(s[:player_id]))
			end

			@scorers[match[:id]][match[:visitor_club_id]] = []
			s2 = Scorer.where(match_id: match[:id], club_id: match[:visitor_club_id])
			s2.each do |s|
				@scorers[match[:id]][match[:visitor_club_id]] << TeamManagementController.helpers.player_name(Player.find(s[:player_id]))
			end
		end

	end
end
