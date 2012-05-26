class Travel < ActiveRecord::Base
  belongs_to :day
  belongs_to :bus
end
