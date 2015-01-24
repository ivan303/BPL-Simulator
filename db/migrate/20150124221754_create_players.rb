class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :firstname
      t.string :lastname
      t.string :commonname
      t.string :position
      t.date :birthdate
      t.integer :overallrating
      t.integer :potential
      t.integer :club_id
      t.string :nationality

      t.timestamps null: false
    end
  end
end
