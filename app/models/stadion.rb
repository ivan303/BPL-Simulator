class Stadion < ActiveRecord::Base
	has_one :club

	validates :name, :capacity, :year_of_construction, :city, presence: true
	validates :name, :city, length: { maximum: 30 }
	validates_numericality_of :year_of_construction, 
		:only_integer => true
end
