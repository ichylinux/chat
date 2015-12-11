class RoomUser < ActiveRecord::Base
  validates :room_id, :presence => true
  validates :name, :presence => true
end
