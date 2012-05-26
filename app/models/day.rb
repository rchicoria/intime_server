class Day < ActiveRecord::Base
  has_many :travels
  has_many :delays
end
