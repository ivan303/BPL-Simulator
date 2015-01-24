class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :firstname
      t.string :lastname
      t.date :date_of_birth

      t.timestamps null: false
    end
  end
end
