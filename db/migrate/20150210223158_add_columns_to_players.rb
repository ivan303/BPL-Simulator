class AddColumnsToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :points, :integer, default: 0
  	add_column :players, :goals_scored, :integer, default: 0
  	add_column :players, :goals_lost, :integer, default: 0
  end
end
