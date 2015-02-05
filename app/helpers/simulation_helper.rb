module SimulationHelper
	
	def simulation players
		# validation connected with players etc.
		round = SeasonInfo.first[:round]

		matchesInRound = Schedule.where(round: round)

		matchesInRound.each do |match|
			byebug
			result = rand(3)
			record = {}

			if result == 0
				record[:result] = "W"
				record[:host_goals] = 1 + rand(5)
				record[:visitor_goals] = rand(record[:host_goals])
				record[:host_club_id] = match[:host]
				record[:visitor_club_id] = match[:visitor]

				Match.create(record)

			elsif result == 1
				record[:result] = "D"
				record[:host_goals] = 1+ rand(5)
				record[:visitor_goals] = record[:host_goals]
				record[:host_club_id] = match[:host]
				record[:visitor_club_id] = match[:visitor]

				Match.create(record)

			elsif result == 2
				record[:result] = "L"
				record[:visitor_goals] = 1 + rand(5)
				record[:host_goals] = rand(record[:visitor_goals])
				record[:host_club_id] = match[:host]
				record[:visitor_club_id] = match[:visitor]

				Match.create(record)
			end
		end

		if SeasonInfo.first[:round] != 38
			SeasonInfo.first.update(roun: round+1)
		else
			# after last round
		end
		
	end
end
