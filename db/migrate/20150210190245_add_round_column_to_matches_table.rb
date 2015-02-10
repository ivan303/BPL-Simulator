class AddRoundColumnToMatchesTable < ActiveRecord::Migration
  def change
  	add_column :matches, :round, :integer
  end
end
