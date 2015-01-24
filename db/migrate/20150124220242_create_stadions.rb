class CreateStadions < ActiveRecord::Migration
  def change
    create_table :stadions do |t|
      t.string :name
      t.integer :capacity
      t.integer :year_of_construction
      t.string :city

      t.timestamps null: false
    end
  end
end
