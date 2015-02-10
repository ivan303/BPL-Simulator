class RemoveThreeWrongColumnsFromPlayers < ActiveRecord::Migration
  def change
  	remove_column :players, :points
  	remove_column :players, :goals_scored
  	remove_column :players, :goals_lost
  end
end
