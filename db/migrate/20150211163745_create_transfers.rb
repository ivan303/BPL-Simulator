class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :player_id
      t.integer :sealing_club
      t.integer :buying_club
      t.integer :cost

      t.timestamps null: false
    end
  end
end
