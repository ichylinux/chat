class RoomsSubscriber < Magellan::Subscriber::Base

  def logging
    logger.info("topic: #{topic}, message: #{body}")
  end

end
