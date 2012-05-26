class Delay < ActiveRecord::Base
  belongs_to :day
  belongs_to :stop_position
end
