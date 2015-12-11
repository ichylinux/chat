require 'test_helper'

class RoomTest < ActiveSupport::TestCase

  def test_name_presence
    r = Room.new
    assert r.invalid?

    r.name = 'RoomTest'
    assert r.valid?
  end

end
