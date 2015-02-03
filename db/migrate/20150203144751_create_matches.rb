class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :result
      t.integer :host_goals
      t.integer :visitor_goals
      t.integer :host_club_id
      t.integer :visitior_club_id

      t.timestamps null: false
    end
  end
end
