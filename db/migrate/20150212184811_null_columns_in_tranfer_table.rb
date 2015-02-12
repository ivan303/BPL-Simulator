class NullColumnsInTranferTable < ActiveRecord::Migration
  def change
  	change_column :transfers, :created_at, :datetime, null: true
  	change_column :transfers, :updated_at, :datetime, null: true
  end
end
