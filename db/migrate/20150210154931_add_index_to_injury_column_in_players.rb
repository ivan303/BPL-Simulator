class AddIndexToInjuryColumnInPlayers < ActiveRecord::Migration
  def change
  	add_index(:players, :injury)
  end
end
