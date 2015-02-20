class PlayersController < ApplicationController
	expose_decorated :player
	expose(:players) { filtered_players }
	
	def index
	end

	def new
	end

	def create
		# byebug
		# case player_params["position"]
		# when "goalkeeper"
		# 	player_params["position"] = "B"
		# when "defender"
		# 	player_params["position"] = "O"
		# end
		# byebug



		self.player = Player.new(player_params)

		player.potential = player.overallrating < 98 ? player.overallrating + 2 : player.overallrating

		player.club_id = Club.find_by(name: SeasonInfo.first.club_name).id
		
		player.cost = 20000000
		player.nationality = 'Poland'

		player.id = Player.all.order(:id).last.id + 1
		byebug

		if player.valid?
			player.save
			flash[:notice] = "Players successfully added to your team"
			redirect_to team_management_path
		else
			render 'players/new'
		end
	end

	def update
		my_club = Club.find_by(name: SeasonInfo.first.club_name)
		player_club = Club.find(player.club_id)
		
		
		if player_club.id == my_club.id
			flash[:error] = "You cannot buy player from your club"
			redirect_to search_path
		else
			if my_club.budget < player.cost
				flash[:error] = "Your budget is too small to buy this player"
				redirect_to search_path
			else
				# make an offer
				p = rand(3)
				if p == 0 # deal
					ActiveRecord::Base.connection.execute("SELECT transfer(#{player_club.id},#{my_club.id},#{player.id})")
					flash[:notice] = "#{player_club.name} accepted your offer. #{player.player_name_formatted} is now in your team."
					redirect_to team_management_path
				else # no deal
					flash[:notice] = "#{player_club.name} rejected your offer."
					redirect_to team_management_path
				end
				
			end
		end
	end

	def parent_object
	end

	def filtered_players
		filtered = Player.all

		filtered = filtered.search_name(params['name']) if params['name'].present?
		filtered = filtered.search_rating(params['overallrating']) if params['overallrating'].present?
		filtered = filtered.search_rating_min(params['min_rating']) if params['min_rating'].present?
		filtered = filtered.search_rating_max(params['max_rating']) if params['max_rating'].present?
		filtered = filtered.search_position(params['position']) if params['position'].present?

		return filtered
	end

	def player_params
    	params.require(:player).permit(:id, :firstname, :lastname, :commonname, :position, :overallrating)
  	end




end
