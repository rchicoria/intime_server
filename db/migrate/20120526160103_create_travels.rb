class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.time :start_time
      t.integer :day_id
      t.integer :bus_id

      t.timestamps
    end
  end
end
