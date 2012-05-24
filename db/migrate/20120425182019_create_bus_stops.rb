class CreateBusStops < ActiveRecord::Migration
  def change
    create_table :bus_stops do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.timestamps
    end
  end
end
