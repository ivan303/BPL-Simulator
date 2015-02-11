class Transfer < ActiveRecord::Base
	belongs_to :player

	belongs_to :sealing_club, :class_name => 'Club', :foreign_key => :sealing_club
	belongs_to :buying_club, :class_name => 'Club', :foreign_key => :buying_club
end
