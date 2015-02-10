class CreateScorers < ActiveRecord::Migration
  def change
    create_table :scorers do |t|
      t.integer :match_id
      t.integer :club_id
      t.integer :player_id

      t.timestamps null: false
    end
  end
end
