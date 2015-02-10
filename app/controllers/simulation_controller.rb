class SimulationController < ApplicationController
	include SimulationHelper

	def create
		# bedzie tu wywoływana metoda dokonująca symulacji
		# w przypadku poprawnych danych wyrenderuje akcję show
		# w przeciwnym wypadku powróci do okna managera

		#byebug
		@players = params[:players]

		all_players = !@players.keys.any? { |k| @players[k].blank? }
		if all_players
			unique_players = @players.values.uniq.length
			if unique_players == 11
				# check if chosen players doesn't have injury
				without_injury = !@players.values.any? { |id| Player.find(id).injury }
				if without_injury
					simulation @players
					redirect_to simulation_path	
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
	end
end
