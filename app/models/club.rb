class Club < ActiveRecord::Base
	belongs_to :stadion
	belongs_to :coach
	has_many :players

	has_many :host, :class_name => "Match", :foreign_key => :host_club_id
	has_many :visitor, :class_name => "Match", :foreign_key => :visitor_club_id

	has_many :host, :class_name => "Schedule", :foreign_key => :host
	has_many :visitor, :class_name => "Schedule", :foreign_key => :visitor

	has_many :scorers

	has_many :buying_club, :class_name => "Transfer", :foreign_key => :buying_club
	has_many :sealing_club, :class_name => "Transfer", :foreign_key => :sealing_club
	
end
