require 'json'
require 'active_record/validations'

class RoomsSubscriber < Magellan::Subscriber::Base

  def logging
    logger.info("topic: #{topic}, message: #{body}")

    begin
      m = /^worker\/rooms\/([0-9]+)\/?(.*)?$/.match(topic)
      if m
        room_id = m[1].to_i
        room = Room.find(room_id)

        data = JSON.parse(body)
        log = RoomLog.new(room_id: room.id, name: data["name"], topic: topic, message: data["message"])
        log.save!
      end
    rescue ::ActiveRecord::RecordNotFound
      logger.error("Room is not found")
    rescue ::ActiveRecord::RecordInvalid => err
      logger.error("Can't save log: #{err.message}")
    end
  end

end