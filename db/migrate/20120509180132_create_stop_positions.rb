class CreateStopPositions < ActiveRecord::Migration
  def change
    create_table :stop_positions do |t|
      t.integer :bus_id
      t.integer :bus_stop_id
      t.integer :position
      t.timestamps
    end
  end
end
