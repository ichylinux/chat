require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def test_create
    post :create, :room_id => Room.first.id, :name => 'test_user'
    assert_response :success
  end

end
