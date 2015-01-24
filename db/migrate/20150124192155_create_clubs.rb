class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :stadium_id
      t.integer :budget
      t.integer :stats
      t.integer :coach_id
      t.integer :established

      t.timestamps null: false
    end
  end
end
