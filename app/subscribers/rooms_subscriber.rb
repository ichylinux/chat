require 'json'
require 'active_record/validations'

class RoomsSubscriber < Magellan::Subscriber::Base

  def logging
    if false
      logger.info("topic: #{topic}, message: #{body}")
    else
      begin
        m = /^worker\/rooms\/([0-9]+)\/?(.*)?$/.match(topic)
        if m
          data = JSON.parse(body)
          username = data["username"]
          message = data["message"]
          room_id = m[1].to_i
          room = Room.find(room_id)
          log = RoomLog.new(room_id: room.id, username: username, topic: topic, message: message)
          log.save!
        end
      rescue ::ActiveRecord::RecordNotFound
        logger.error("Room is not found")
      rescue ::ActiveRecord::RecordInvalid => err
        logger.error("Can't save log: #{err.message}")
      end
    end
  end

end