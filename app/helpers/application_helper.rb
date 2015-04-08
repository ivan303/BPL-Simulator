module ApplicationHelper
	
require 'smarter_csv'

	def bootstrap_class_for flash_type
		case flash_type
			when "success"
				"alert-success"
			when "alert"
				"alert-warning"
			when "notice"
				"alert-info"
			when "error"
				"alert-danger"
			else
				flash_type.to_s
		end
	end

	def import_players_from_csv
		options = {}
		filename = "PLAYERSFINAL2.csv"
		SmarterCSV.process(filename, options) do |chunk|
			chunk.each do |data_hash|				
				Player.create!({
					:id => data_hash[:id],
					:firstname => data_hash[:firstname].nil? ? nil : data_hash[:firstname],
					:lastname => data_hash[:lastname].nil? ? nil : data_hash[:lastname],
					:commonname => data_hash[:commonname].nil? ? nil : data_hash[:commonname],
					:position => data_hash[:position],
					:birthdate => data_hash[:birthdate].nil? ? nil : DateTime.strptime(data_hash[:birthdate], "%m/%d/%Y").strftime("%d/%m/%Y"),
					:overallrating => data_hash[:overallrating],
					:potential => data_hash[:potential],
					:club_id => data_hash[:clubid],
					:nationality => data_hash[:nationality]
					})
			end
		end
	end

	def import_clubs_from_csv
		options = {}
		filename = "CLUBSFINAL.csv"
		SmarterCSV.process(filename, options) do |chunk|
			chunk.each do |data_hash|				
				Club.create!({
					:id => data_hash[:id],
					:name => data_hash[:name],
					:stadion_id => data_hash[:stadium_id],
					:budget => data_hash[:budget],
					:stats => data_hash[:stats],
					:coach_id => data_hash[:coach_id],
					:established => data_hash[:established]
					})
			end
		end
	end

	def import_coaches_from_csv
		options = {}
		filename = "COACHESFINAL1.csv"
		SmarterCSV.process(filename, options) do |chunk|
			chunk.each do |data_hash|				
				Coach.create!({
					:id => data_hash[:id],
					:firstname => data_hash[:firstname],
					:lastname => data_hash[:lastname],
					:birthdate => data_hash[:birthdate].nil? ? nil : DateTime.strptime(data_hash[:birthdate], "%m/%d/%Y").strftime("%d/%m/%Y"),
					})
			end
		end
	end

	def import_stadions_from_csv
		options = {}
		filename = "STADIUMSFINAL.csv"
		SmarterCSV.process(filename, options) do |chunk|
			chunk.each do |data_hash|				
				Stadion.create!({
					:id => data_hash[:id],
					:name => data_hash[:name],
					:capacity => data_hash[:capacity],
					:year_of_construction => data_hash[:year_of_construction],
					:city => data_hash[:city]
					})
			end
		end
	end

	def import_schedule
		filename = "SCHEDULE.csv"

		options = {}
		schedule = {}
					
		counter = 1
		round = 1
		SmarterCSV.process(filename, options) do |chunk|

			if counter == 1
				schedule[round] = {}
			end
			schedule[round][chunk[0][:host]] = chunk[0][:visitor]
			counter += 1
			if counter == 11
				counter = 1
				round += 1
			end
		end

		schedule.each do |key, value|
			value.each do |h, v|
				hostRecord = Club.find_by(:name => h)
				visitorRecord = Club.find_by(:name => v)

				Schedule.create!({
					:round => key,
					:host => hostRecord[:id],
					:visitor => visitorRecord[:id]
					})
			end
		end

		return schedule
	end


	def tester filename
		options = {}
		SmarterCSV.process(filename, options) do |chunk|
			chunk.each do |data_hash|
				puts data_hash				
			end
		end
	end

	def update_clubs_stats
		@clubs = Club.all
		@clubs.each do |c|
			playersNumber = 0
			ratingSum = 0
			potentialSum = 0
			c.players.each do |p|
				playersNumber += 1
				ratingSum += p[:overallrating]
				potentialSum += p[:potential]
			end
			ratingAverage = ratingSum/playersNumber
			potentialAverage = potentialSum/playersNumber
			average = ratingAverage + potentialAverage
			average /= 2
			
			c.update(stats: average)
		end
	end

	def update_players_costs
		players = Player.all

		players.each do |p|
			offset = rand(10)+1
			cost = 0
			cost += (p.overallrating/90.0)*20000000
			cost += (p.potential/90.0)*5000000
			case offset
			when 1..5
				cost += offset*1000000
			when 6..10
				cost -= (offset-5)*1000000
			end

			cost = cost.round

			p.update(cost: cost)

		end
	end

end
