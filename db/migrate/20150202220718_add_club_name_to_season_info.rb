class AddClubNameToSeasonInfo < ActiveRecord::Migration
  def change
  	add_column :season_infos, :club_name, :string
  end
end
