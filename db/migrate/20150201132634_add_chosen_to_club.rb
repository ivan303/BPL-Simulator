class AddChosenToClub < ActiveRecord::Migration
  def change
    add_column :clubs, :chosen, :boolean, default: false
  end
end
