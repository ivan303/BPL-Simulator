class AddCostColumnToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :cost, :integer, default: 0
  end
end
