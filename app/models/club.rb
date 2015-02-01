class Club < ActiveRecord::Base
	belongs_to :stadion
	belongs_to :coach
	has_many :players

	
end
