class Schedule < ActiveRecord::Base
	belongs_to :host, :class_name => "Club", :foreign_key => :host
	belongs_to :visitor, :class_name => "Club", :foreign_key => :visitor
end
