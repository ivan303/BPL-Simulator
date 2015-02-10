class AddInjuryColumnToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :injury, :boolean
  end
end
