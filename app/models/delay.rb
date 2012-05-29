class Delay < ActiveRecord::Base
  belongs_to :day
  belongs_to :stop_position

  # Get how many minutes the user has to wait
  def remaining_minutes()
    current_time = Time.now
    start_time = find_newest_travel_time(stop_position.bus.id, current_time)
    predicted_time = start_time + minutes_delayed * 60
    return predicted_time - current_time
  end

  # Get the delay for the current time for the desired stop position
  def self.get_or_create_delay(stop_position)
    current_time = Time.now
    delay = Delay.get_delay(stop_position.id, current_time)
    return delay unless delay.nil? # Neste momento ainda não actualiza o valor do delay
    return create_new(stop_position.id, current_time)
  end

  # Get a certain delay
  def self.get_delay(stop_position_id, current_time)
    return Delay.where('stop_position_id = ? and this_hour = ? and day_id = ?',
                        stop_position_id,
                        current_time.hour,
                        Delay.find_day_id(current_time)).first
  end

  private

    # Helper to create a new delay
    def create_new(stop_position_id, current_time)
      start_time = find_newest_travel_time(StopPosition.find(stop_position_id).bus.id, current_time)
      return Delay.create(stop_position_id: stop_position_id,
                          day_id: Delay.find_day_id(current_time),
                          this_hour: start_time.hour,
                          minutes_delayed: ((current_time - start_time)/60).floor,
                          precision: 1)
    end

    # Helper to find the day_id of the current_time
    def self.find_day_id(current_time)
      return day_id = 2 if current_time.saturday?
      return day_id = 3 if current_time.sunday?
      return day_id = 1
    end

    # Find the time that the bus started its current travel
    def find_newest_travel_time(bus_id, current_time)
      start_time = 0
      Travel.where('bus_id = ?', bus_id).each do |travel|
        travel_time = Time.utc(2000, "jan", 1, travel.start_time.hour, travel.start_time.min, 0)
        start_time = travel_time if start_time == 0 or (travel_time > start_time and current_time > travel_time)
      end
      return start_time
    end
end
