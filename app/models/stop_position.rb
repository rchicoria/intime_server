class StopPosition < ActiveRecord::Base
  
  belongs_to :bus
  belongs_to :bus_stop
  has_many :delays

  # Return predicted arrival time based on StopPosition's Delay
  def predicted_time()
    return nil if Travel.where('bus_id = ?', bus.id).empty?
    current_time = Time.now
    delay = Delay.get_delay(stop_position_id, current_time)
    return nil if delay.nil?
    start_time = 0
    Travel.where('bus_id = ?', bus.id).each do |travel|
      travel_time = Time.utc(2000, "jan", 1, travel.start_time.hour, travel.start_time.min, 0)
      start_time = travel_time if start_time == 0 or (travel_time > start_time and current_time > travel_time)
    end
    return current_time - [start_time + (delay.minutes_delayed * 60), current_time].max
  end
end