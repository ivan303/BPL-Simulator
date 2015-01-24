module ApplicationHelper
	
require 'smarter_csv'

	def import_from_csv filename, model
		options = {}
		SmarterCSV.process(filename, options) do |chunk|
			chunk.each do |data_hash|				
#				model.create!(data_hash)
				model.create!({
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

	def tester filename
		options = {}
		SmarterCSV.process(filename, options) do |chunk|
			chunk.each do |data_hash|
				puts data_hash
				#puts data_hash[:id]
				#puts DateTime.strptime(data_hash[:birthdate] ,"%m/%d/%Y").strftime("%d/%m/%Y")
				
			end
		end
	end

	def helloo
		#helloo 1
		#print "hello"
		puts "hello"
	end
end
