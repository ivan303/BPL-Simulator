class RenameColumnBirthdateInTableCoaches < ActiveRecord::Migration
  def change
  	rename_column :coaches, :date_of_birth, :birthdate
  end
end
