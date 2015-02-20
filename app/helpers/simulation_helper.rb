module SimulationHelper
	
	def simulation player_from_form
		# validation connected with players etc.
		

		user_club_id = Club.find_by(name: SeasonInfo.first[:club_name])[:id]

		round = SeasonInfo.first[:round]

		matchesInRound = Schedule.where(round: round)

		# remove injuries from previous round
		Player.where(injury: true).each { |p| p.update(injury: false)}


		players = {}
		player_from_form.each do |key, ind|
			players[key] = Player.find(ind)
		end


		matchesInRound.each do |match|
				
			if match[:host] == user_club_id 
				#byebug
				players1 = players
				host_offensive_power = power players, "off"
				host_defensive_power = power players, "def"

				players2 = random_players match[:visitor]
				visitor_offensive_power = power players2, "off"
				visitor_defensive_power = power players2, "def"

			elsif match[:visitor] == user_club_id
				#byebug
				players2 = players
				visitor_offensive_power = power players, "off"
				visitor_defensive_power = power players, "def"

				players1 = random_players match[:host]
				host_offensive_power = power players1, "off"
				host_defensive_power = power players1, "def"
			
			else
				#byebug
				players1 = random_players match[:host]
				host_offensive_power = power players1, "off"
				host_defensive_power = power players1, "def"

				players2 = random_players match[:visitor]
				visitor_offensive_power = power players2, "off"
				visitor_defensive_power = power players2, "def"
			end

				
			# delete this block later	
			#byebug
			puts "Host: " + Club.find(match[:host])[:name]
			#puts "Host off power: " + host_offensive_power.to_s
			#puts "Host def power: " + host_defensive_power.to_s
			puts "Visitor: " + Club.find(match[:visitor])[:name]
			#puts "Visitor off power: " + visitor_offensive_power.to_s
			#puts "Visitor def power: " + visitor_defensive_power.to_s



			# byebug
			# 
			# simulatin match result
			#
			random_result = rand(50) + 1
			host_power = host_defensive_power + host_offensive_power
			visitor_power = visitor_defensive_power + visitor_offensive_power
			power_difference = host_power - visitor_power

			# host is stronger
			if power_difference >= 0
				host_points = 10 + power_difference/50 + 5
				visitor_points = 10
				draw_points = 50 - host_points - visitor_points

				if random_result <= host_points
					result = 0
				elsif random_result > host_points and random_result <= host_points + draw_points
					result = 1
				else 
					result = 2
				end
			# visitor is stronger
			elsif
				power_difference = -power_difference
				host_points = 10 + 5
				visitor_points = 10 + power_difference/50
				draw_points = 50 - host_points - visitor_points

				if random_result <= host_points
					result = 0
				elsif random_result > host_points and random_result <= host_points + draw_points
					result = 1
				else 
					result = 2
				end

			end
			
			record = {}

			if result == 0
				record[:result] = "W"
				record[:host_goals] = 1 + rand(5)
				record[:visitor_goals] = rand(record[:host_goals])
				record[:host_club_id] = match[:host]
				record[:visitor_club_id] = match[:visitor]
				record[:round] = round

				m = Match.create(record)

				club = Club.find(match[:host])
				club.points = club.points + 3
				club.goals_scored = club.goals_scored + record[:host_goals]
				club.goals_lost = club.goals_lost + record[:visitor_goals]
				club.save

				club = Club.find(match[:visitor])
				club.goals_scored = club.goals_scored + record[:visitor_goals]
				club.goals_lost = club.goals_lost + record[:host_goals]
				club.save

				scorers_and_injuries m[:id], record[:host_club_id], record[:visitor_club_id], record[:host_goals], record[:visitor_goals], players1, players2

			elsif result == 1
				record[:result] = "D"
				record[:host_goals] = 1+ rand(5)
				record[:visitor_goals] = record[:host_goals]
				record[:host_club_id] = match[:host]
				record[:visitor_club_id] = match[:visitor]
				record[:round] = round

				m = Match.create(record)

				club = Club.find(match[:host])
				club.points = club.points + 1
				club.goals_scored = club.goals_scored + record[:host_goals]
				club.goals_lost = club.goals_lost + record[:visitor_goals]
				club.save

				club = Club.find(match[:visitor])
				club.points = club.points + 1
				club.goals_scored = club.goals_scored + record[:visitor_goals]
				club.goals_lost = club.goals_lost + record[:host_goals]
				club.save

				scorers_and_injuries m[:id], record[:host_club_id], record[:visitor_club_id], record[:host_goals], record[:visitor_goals], players1, players2

			elsif result == 2
				record[:result] = "L"
				record[:visitor_goals] = 1 + rand(5)
				record[:host_goals] = rand(record[:visitor_goals])
				record[:host_club_id] = match[:host]
				record[:visitor_club_id] = match[:visitor]
				record[:round] = round

				m = Match.create(record)

				club = Club.find(match[:host])
				club.goals_scored = club.goals_scored + record[:host_goals]
				club.goals_lost = club.goals_lost + record[:visitor_goals]
				club.save

				club = Club.find(match[:visitor])
				club.points = club.points + 3
				club.goals_scored = club.goals_scored + record[:visitor_goals]
				club.goals_lost = club.goals_lost + record[:host_goals]
				club.save

				scorers_and_injuries m[:id], record[:host_club_id], record[:visitor_club_id], record[:host_goals], record[:visitor_goals], players1, players2

			end

			#byebug
			puts result

			# simulating transfers
			make_transfers


		end





		if SeasonInfo.first[:round] != 39
			SeasonInfo.first.update(round: round+1)
		else
			# after last round
		end
	end

	def make_transfers
		my_club = Club.find_by(name: SeasonInfo.first.club_name)

		my_club = Club.find(1)

		players = Player.all.as_json

		clubs = Club.all.where.not(id: my_club.id)

		clubs.each do |c|

			budget = c.budget
			poss_players = []
			players.each do |p|
				if p["cost"] <= budget and p["club_id"] != c.id and p["position"] != "B"
					poss_players << p
				end
			end

			unless poss_players.empty?
				player_index = rand(poss_players.length)
				poss = rand(6)
				if poss == 0
					# all operation connected with transfer
					club_from_id = poss_players[player_index]["club_id"]
					club_to_id = c.id
					player_id = poss_players[player_index]["id"]

					
					ActiveRecord::Base.connection.execute("SELECT transfer(#{club_from_id},#{club_to_id},#{player_id})")
					#byebug
				end
			end


			#puts c.name + ' ' + poss_players.length.to_s

		end




	end

	def scorers_and_injuries match_id, host_id, visitor_id, host_goals, visitor_goals, host_players, visitor_players
		host_strikers = []
		host_midfielders = []
		host_defenders = []
		visitor_strikers = []
		visitor_midfielders = []
		visitor_defenders = []


		# simulating injuries
		injury = rand(8)
		if injury == 0
			offset1 = rand(11)
			offset2 = rand(11)
			while offset2 == offset1
				offset2 = rand(11)
			end
			#byebug

			key1 = 'id_' + (offset1+1).to_s
			key2 = 'id_' + (offset2+1).to_s
			host_players[key1].update(injury: true)
			host_players[key2].update(injury: true)
		elsif injury == 1 or injury == 2
			offset1 = rand(11)
			#byebug
			key1 = 'id_' + (offset1+1).to_s
			host_players[key1].update(injury: true)
		end

		injury = rand(8)
		if injury == 0
			offset1 = rand(11)
			offset2 = rand(11)
			while offset2 == offset1
				offset2 = rand(11)
			end
			#byebug


			key1 = 'id_' + (offset1+1).to_s
			key2 = 'id_' + (offset2+1).to_s
			visitor_players[key1].update(injury: true)
			visitor_players[key2].update(injury: true)
		elsif injury == 1 or injury == 2
			#byebug
			offset1 = rand(11)
			key1 = 'id_' + (offset1+1).to_s
			visitor_players[key1].update(injury: true)
		end



		host_players.each do |key, value|
			case value[:position]
			when 'N'
				host_strikers << value
			when 'P'
				host_midfielders << value
			when 'O'
				host_defenders << value
			end
		end

		visitor_players.each do |key, value|
			case value[:position]
			when 'N'
				visitor_strikers << value
			when 'P'
				visitor_midfielders << value
			when 'O'
				visitor_defenders << value
			end
		end

		#byebug


		for i in 1..host_goals
			#byebug
			if host_strikers.length != 0 and host_midfielders.length != 0 and host_defenders.length !=0
				scorer_position = rand(10)
			elsif host_strikers.length == 0
				scorer_position = rand(4) + 6
			end
				

			#scorer_position = rand(10)
			case scorer_position
			when 0..5
				num = rand(host_strikers.length)
				byebug
				Scorer.create({
					match_id: match_id,
					club_id: host_id,

					player_id: host_strikers[num][:id]
					})
			when 6..8
				num = rand(host_midfielders.length)
				Scorer.create({
					match_id: match_id,
					club_id: host_id,
					player_id: host_midfielders[num][:id]
					})
			when 9
				num = rand(host_defenders.length)
				Scorer.create({
					match_id: match_id,
					club_id: host_id,
					player_id: host_defenders[num][:id]
					})
			end
		end
	
		for i in 1..visitor_goals
			if visitor_strikers.length != 0 and visitor_midfielders.length != 0 and visitor_defenders.length !=0
				scorer_position = rand(10)
			elsif visitor_strikers.length == 0
				scorer_position = rand(4) + 6
			end

			#scorer_position = rand(10)
			case scorer_position
			when 0..5
				num = rand(visitor_strikers.length)
				Scorer.create({
					match_id: match_id,
					club_id: visitor_id,
					player_id: visitor_strikers[num][:id]
					})
			when 6..8
				num = rand(visitor_midfielders.length)
				Scorer.create({
					match_id: match_id,
					club_id: visitor_id,
					player_id: visitor_midfielders[num][:id]
					})
			when 9
				num = rand(host_defenders.length)
				Scorer.create({
					match_id: match_id,
					club_id: visitor_id,
					player_id: visitor_defenders[num][:id]
					})
			end
		end

	end

	def power players, power_type
		#byebug

		goalkeeper = nil
		defenders = Array.new
		midfielders = Array.new
		strikers = Array.new

		players.each do |key, value|
			#byebug
			#player = Player.find(value)
			player = value

			unless player
				byebug
			end

			case player[:position]
			when "B"
				goalkeeper = player
			when "O"
				defenders << player
			when "P"
				midfielders << player
			when "N"
				strikers << player
			end
		end

		divider = 0
		power = 0

		if power_type == "off"
			power += 0*goalkeeper[:overallrating]
			divider += 0

			defenders.each do |d|
				power += 2*d[:overallrating]
				divider += 2
			end

			midfielders.each do |m|
				power += 4*m[:overallrating]
				divider += 4
			end

			strikers.each do |s|
				power += 8*s[:overallrating]
				divider += 8
			end

		elsif power_type == "def"
			power += 6*goalkeeper[:overallrating]
			divider += 6

			defenders.each do |d|
				power += 6*d[:overallrating]
				divider += 6
			end

			midfielders.each do |m|
				power += 2*m[:overallrating]
				divider += 2
			end

			strikers.each do |s|
				power += 1*s[:overallrating]
				divider += 1
			end
		end

		power
	end

	def random_players club_id 
		goalkeepers = Array.new
		defenders = Array.new
		midfielders = Array.new
		strikers = Array.new

		players = Player.where(club_id: club_id)
		players.each do |p|
			if p[:position] == "B" and p[:injury] == false
				goalkeepers << p 
			elsif p[:position] == "O" and p[:injury] == false
				defenders << p 
			elsif p[:position] == "P" and p[:injury] == false
				midfielders << p 
			elsif p[:position] == "N" and p[:injury] == false
				strikers << p 
			end
		end

		players_for_match = {}
		for i in 1..11
			key = "id_" + i.to_s
			if i == 1
				players_for_match[key] = goalkeepers[rand(goalkeepers.length)]
			elsif i<=5 and i>=2
				if defenders.length > 0
					ind = rand(defenders.length)
					players_for_match[key] = defenders[ind]
					defenders.delete_at(ind)
				else
					ind = rand(midfielders.length)
					players_for_match[key] = midfielders[ind]
					midfielders.delete_at(ind)
				end
			elsif i<=9 and i>=6
				if midfielders.length > 0
					ind = rand(midfielders.length)
					players_for_match[key] = midfielders[ind]
					midfielders.delete_at(ind)
				else
					ind = rand(strikers.length)
					players_for_match[key] = strikers[ind]
					strikers.delete_at(ind)
				end
			elsif i<=11 and i>=10
				if strikers.length > 0
					ind = rand(strikers.length)
					players_for_match[key] = strikers[ind]
					strikers.delete_at(ind)
				else
					ind = rand(midfielders.length)
					players_for_match[key] = midfielders[ind]
					midfielders.delete_at(ind)
				end
			end
		end

		players_for_match
	end
end
