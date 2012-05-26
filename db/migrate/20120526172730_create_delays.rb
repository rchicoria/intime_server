class CreateDelays < ActiveRecord::Migration
  def change
    create_table :delays do |t|
      t.integer :stop_position_id
      t.integer :day_id
      t.integer :this_hour
      t.integer :minutes_delayed
      t.integer :precision

      t.timestamps
    end
  end
end
