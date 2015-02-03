class CreateSeasonInfos < ActiveRecord::Migration
  def change
    create_table :season_infos do |t|

      t.timestamps null: false
    end
  end
end
