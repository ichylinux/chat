require 'test_helper'

class RoomUserTest < ActiveSupport::TestCase

  def test_room_id_presence
    ru = RoomUser.new(valid_room_user_params)
    assert ru.valid?
    
    ru.room_id = nil
    assert ru.invalid?
  end

  def test_name_presence
    ru = RoomUser.new(valid_room_user_params)
    assert ru.valid?
    
    ru.name = ''
    assert ru.invalid?
  end

  private

  def valid_room_user_params
    {
      room_id: Room.first.id,
      name: 'user_test'
    }
  end

end
