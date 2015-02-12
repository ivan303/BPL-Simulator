class TeamManagementController < ApplicationController

	include  ActionView::Helpers::NumberHelper
	
	expose(:player)
	expose(:players)
	
	def show
		#byebug
		@info = SeasonInfo.first
		
		@chosenClub = Club.find_by(name: @info.club_name)
		
		
		result = ActiveRecord::Base.connection.execute("SELECT costs_sum(#{@chosenClub.id})")
		@players_costs = number_to_currency(number_with_delimiter(result.first["costs_sum"], delimiter: "."), :unit => "£")
		
	end	

	def simulate
		byebug
	end
end
