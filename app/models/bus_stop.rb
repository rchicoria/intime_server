# == Schema Information
#
# Table name: bus_stops
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  lat        :float
#  lon        :float
#  created_at :datetime
#  updated_at :datetime
#

class BusStop < ActiveRecord::Base
  has_many :stop_positions
end