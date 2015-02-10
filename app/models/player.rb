class Player < ActiveRecord::Base
	belongs_to :club 

	validates :position, :presence => true
	validates :position, inclusion: { in: %w(o O p P n N b B)}
	# validates :birthdate
	validates :commonname, presence: true, if: "lastname.nil?"
	validates_numericality_of :overallrating, :only_integer => true, :less_than_or_equal_to => 100
	validates_numericality_of :potential, :only_integer => true, :less_than_or_equal_to => 100
	validates_numericality_of :potential, :greater_than_or_equal_to => :overallrating

	has_many :scorers
end
