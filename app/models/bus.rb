# == Schema Information
#
# Table name: buses
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Bus < ActiveRecord::Base
  has_many :stop_positions
  has_many :travels

  validates_presence_of :name
end