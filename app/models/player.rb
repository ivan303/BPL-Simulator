class Player < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper

	belongs_to :club 

	validates :position, :presence => true
	validates :position, inclusion: { in: %w(o O p P n N b B)}
	# validates :birthdate
	validates :commonname, presence: true, if: "lastname.nil?"
	validates_numericality_of :overallrating, :only_integer => true, :less_than_or_equal_to => 100
	validates_numericality_of :potential, :only_integer => true, :less_than_or_equal_to => 100
	validates_numericality_of :potential, :greater_than_or_equal_to => :overallrating

	has_many :scorers

	has_many :transfers

	def self.search_name(name)
		search_condition = ("%" + name + "%").downcase
		where(['lower(firstname) like ? or lower(lastname) like ? or lower(commonname) like ?', search_condition, search_condition, search_condition])
	end

	def self.search_rating(rating)
		where(['overallrating = ?', rating.to_i])
	end

	def self.search_rating_min(rating)
		where(['overallrating >= ?', rating.to_i])
	end

	def self.search_rating_max(rating)
		where(['overallrating <= ?', rating.to_i])
	end

	# def player_name player
 #  		name = player.commonname || player.firstname + ' ' + player.lastname
 #  	end

 	def player_name_formatted
 		name = commonname || firstname + ' ' + lastname
 	end

 	def player_position_formatted
 		case position
 		when 'B'
 			"Goalkeeper"
 		when 'O'
 			"Defender"
 		when 'P'
 			"Midfielder"
 		when 'N'
 			"Striker"
 		end
 	end

 	def player_cost_formatted
 		number_to_currency(number_with_delimiter(cost, delimiter: "."), :unit => "£")
 	end

end
