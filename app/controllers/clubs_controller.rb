class ClubsController < ApplicationController
	include  ActionView::Helpers::NumberHelper

	expose(:club)
	expose(:clubs)
	expose(:coaches)

	def show
	end
end
