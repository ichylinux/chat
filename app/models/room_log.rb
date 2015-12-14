class RoomLog < ActiveRecord::Base

  before_save :set_topic

  private

  def set_topic
    self.topic ||= "worker/rooms/#{self.room_id}"
  end
end
