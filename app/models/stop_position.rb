class StopPosition < ActiveRecord::Base
  
  belongs_to :bus
  belongs_to :bus_stop
  has_many :delays
end