class AddColumnsToClubs < ActiveRecord::Migration
  def change
  	  	add_column :clubs, :points, :integer, default: 0
  		add_column :clubs, :goals_scored, :integer, default: 0
  		add_column :clubs, :goals_lost, :integer, default: 0
  end
end
