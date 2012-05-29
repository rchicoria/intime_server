class AddActualDelayAndActualDelayTimestampToDelay < ActiveRecord::Migration
  def change
    add_column :delays, :actual_delay, :integer
    add_column :delays, :actual_delay_timestamp, :datetime
  end
end
