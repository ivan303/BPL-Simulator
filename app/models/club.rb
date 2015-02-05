class Club < ActiveRecord::Base
	belongs_to :stadion
	belongs_to :coach
	has_many :players

	has_many :host, :class_name => "Match", :foreign_key => :host_club_id
	has_many :visitor, :class_name => "Match", :foreign_key => :visitor_club_id

	has_many :host, :class_name => "Schedule", :foreign_key => :host
	has_many :visitor, :class_name => "Schedule", :foreign_key => :visitor

	
end
