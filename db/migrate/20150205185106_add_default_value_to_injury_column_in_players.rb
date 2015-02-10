class AddDefaultValueToInjuryColumnInPlayers < ActiveRecord::Migration
  def change
  	remove_column :players, :injury
  	add_column :players, :injury, :boolean, default: false
  end
end
