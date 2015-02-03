class RenameColumnVisitiorClubIdInTableMatch < ActiveRecord::Migration
  def change
  	rename_column :matches, :visitior_club_id, :visitor_club_id
  end
end
