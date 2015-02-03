module TeamManagementHelper
	def player_name player
  		name = player.commonname || player.firstname + ' ' + player.lastname
  	end
end
