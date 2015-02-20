module TeamManagementHelper
	def player_name player
      unless player.commonname.blank?
        player.commonname
      else
        player.firstname + ' ' + player.lastname
      end
  		# name = player.commonname || player.firstname + ' ' + player.lastname
  	end

  	def sort_by_position players
  		goalkeepers = players.where(position: 'B')
  		defenders = players.where(position: 'O')
  		midfielders = players.where(position: 'P')
  		strikers = players.where(position: 'N')

  		positions_array = []
  		positions_array << goalkeepers
  		positions_array << defenders
  		positions_array << midfielders
  		positions_array << strikers

  		sorted_players = []

  		counter = 0
  		positions_array.each do |pos|
  			sorted_players[counter] = []
  			pos.each do |pla|
  				sorted_players[counter] << pla
  			end
  			counter += 1
  		end

  		sorted_players
  	end

  	def without_injury players
  		players_without_injury = []
  		byebug
  		players.each do |pl|
  			unless pl.injury players_without_injury << pl
  			end
  		end
  		players_without_injury
  	end

end
