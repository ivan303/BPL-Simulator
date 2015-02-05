module ChooseTeamHelper
	def create_schedule club
		schedule = Hash.new
		counter = 1
		clubsToCreateSchedule = Club.all

		schedule[1] = Hash.new
		schedule[1][0] = club
		clubsToCreateSchedule.each do |c|
			unless c[:name] == club
				schedule[1][counter] = c[:name] 
				counter += 1
			end
		end

		
		for i in 2..20
			#schedule[i] = Hash.new
			#schedule[i][0] = schedule[1][i-1]






			counter = 0
			schedule[i] = Hash.new
			for j in 0..19
				if j == 0
					schedule[i][j] = schedule[i-1][19]
				else
					schedule[i][j] = schedule[i-1][j-1]
				end
			end
		end

		# creating table with schedule
		for i in 1..20			
			scheduleForTeam = Schedule.new(schedule[i])
			scheduleForTeam.save
		end

		return schedule
	end

	def create_schedule1 schedule
		# scheduleToTable = {}
		
		# tableOfKeys = schedule[1].keys
		# tableOfValues = schedule[1].values
		# for i in 1..20
		# 	scheduleToTable[i] = {}
		# 	if i <= 10
		# 		scheduleToTable[i][0] = tableOfKeys[i-1]
		# 	end
		# 	if i > 10
		# 		scheduleToTable[i][0] = tableOfValues[i-11]
		# 	end
		# end


		# for j in 1..38
		# 	puts j
		# 	puts
		# 	puts
		# 	for i in 1..20
		# 		byebug
		# 		clubInRow = scheduleToTable[i][0]
		# 		if schedule[j].has_key?(clubInRow) 
		# 			scheduleToTable[i][j] = schedule[j][clubInRow]
		# 		else
		# 			scheduleToTable[i][j] = schedule[j].key(clubInRow)
		# 		end
		# 	end
		# end




		for i in 1..20
			keyArray = schedule[i].keys
			keyArray.each do |key|
				#row = Schedule.new(:round => i, :host => key, :visitor => schedule[i][key])
				puts key + schedule[i][key]
			end
			# schedule[i].each do |round|
			# 	keyArray = round.keys
			# 	row = Schedule.new(:round => i, :host => round.key)
		end

		#return scheduleToTable
	end
end
