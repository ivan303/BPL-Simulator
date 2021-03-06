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
		
		for i in 1..20
			keyArray = schedule[i].keys
			keyArray.each do |key|
		
				puts key + schedule[i][key]
			end
		end
	end
end
