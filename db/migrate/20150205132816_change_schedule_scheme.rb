class ChangeScheduleScheme < ActiveRecord::Migration
  def change
  	for i in 0..19
  		remove_column :schedules, i
  	end
  	add_column :schedules, :round, :integer
  	add_column :schedules, :host, :string
  	add_column :schedules, :visitor, :string
  end
end
