class ChangeColumnsTypesInSchedule < ActiveRecord::Migration
  def change
  	remove_column :schedules, :host
  	remove_column :schedules, :visitor

  	add_column :schedules, :host, :integer
  	add_column :schedules, :visitor, :integer
  end
end
