class ChangeForeignKeyColumnNameForStadionInClub < ActiveRecord::Migration
  def change
  	rename_column :clubs, :stadium_id, :stadion_id
  end
end
