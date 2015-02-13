class SearchController < ApplicationController
	def search_params
		params.permit(:search, :overallrating, :name, :position)
	end
end
