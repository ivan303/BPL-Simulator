class LeagueResultController < ApplicationController
	def show
		@results = Club.all.order(:points, :goals_scored).reverse_order
	end
end
