class AddColumnsToSchedule < ActiveRecord::Migration
  def change
  	for i in 0..19
  		add_column :schedules, i, :string, default: nil
  	end
  end
end
