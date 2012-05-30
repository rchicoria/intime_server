class StopPosition < ActiveRecord::Base
  
  belongs_to :bus
  belongs_to :bus_stop
  has_many :delays

  # Return predicted arrival time based on StopPosition's Delay
  def predicted_time(previous_stops = nil)
    return nil if Travel.where('bus_id = ?', bus.id).empty?
    current_time = Time.now
    current_time_normal = Time.utc(2000, "jan", 1, current_time.hour, current_time.min, 0)
    delay = Delay.get_delay(id, current_time)
    return nil if delay.nil?
    start_time = 0
    list = Travel.where('bus_id = ?', bus_id).sort_by {|obj| obj.start_time}
    list.each do |travel|
      travel_time = Time.utc(2000, "jan", 1, travel.start_time.hour, travel.start_time.min, 0)
      start_time = travel_time if start_time == 0 or (travel_time > start_time and current_time_normal > travel_time)
    end

    actual_delay = 0

    if previous_stops
      previous_stops.reverse_each do |previous_stop|
        previous_stop_delay = Delay.get_delay(previous_stop.id, current_time)
        if previous_stop_delay
          if previous_stop_delay.actual_delay and (current_time - previous_stop_delay.actual_delay_timestamp.to_time)/60 < 30
            actual_delay = previous_stop_delay.actual_delay
            break
          end
        end
      end
    end

    delayed_date = start_time + (delay.minutes_delayed*60)

    delayed_date = Time.utc(2000, "jan", 1, delayed_date.hour, delayed_date.min, 0)

    current_time = Time.utc(2000, "jan", 1, current_time.hour, current_time.min, 0)

    return ([delayed_date + actual_delay*60, current_time].max - current_time)/60
  end
end