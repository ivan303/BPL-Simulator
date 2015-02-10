class Match < ActiveRecord::Base
	belongs_to :host, :class_name => "Club", :foreign_key => :host_club_id
	belongs_to :visitor, :class_name => "Club", :foreign_key => :visitor_club_id

	validates :result, :host_goals, :visitor_goals, :host_club_id, :visitor_club_id, :presence => true

	has_many :scorers
end
