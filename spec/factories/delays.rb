# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :delay do
    stop_position_id 1
    day_id 1
    this_hour 1
    minutes_delayed 1
    precision 1
  end
end
