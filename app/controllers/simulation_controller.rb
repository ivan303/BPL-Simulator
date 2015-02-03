class SimulationController < ApplicationController
	def create
		# bedzie tu wywoływana metoda dokonująca symulacji
		# w przypadku poprawnych danych wyrenderuje akcję show
		# w przeciwnym wypadku powróci do okna managera

		@players = params[:players]
		
		redirect_to simulation_path
	end

	def show
	end
end
