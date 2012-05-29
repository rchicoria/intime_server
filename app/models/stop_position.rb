class StopPosition < ActiveRecord::Base
  
  belongs_to :bus
  belongs_to :bus_stop
  has_many :delays

  # Return predicted arrival time based on StopPosition's Delay
  def predicted_time()
    return nil if Travel.where('bus_id = ?', bus.id).empty?
    current_time = Time.now
    if current_time.saturday?
      day_id = 2
    elsif current_time.sunday?
      day_id = 3
    else
      day_id = 1
    end
    delay = Delay.where('stop_position_id = ? and this_hour = ? and day_id = ?', id, current_time.hour, day_id).first
    start_time = 0
    Travel.where('bus_id = ?', bus.id).each do |travel|
      travel_time = Time.utc(2000, "jan", 1, travel.start_time.hour, travel.start_time.min, 0)
      start_time = travel_time if start_time == 0 or (travel_time > start_time and current_time > travel_time)
    end
    if delay.nil?
      return nil
    else
      return [start_time + (delay.minutes_delayed * 60), current_time].max
    end
  end
end