class AddRoundToSeasonInfo < ActiveRecord::Migration
  def change
  	add_column :season_infos, :round, :integer
  end
end
