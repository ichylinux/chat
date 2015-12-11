require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def test_create
    post :create, :room_id => Room.first.id, :name => 'test_user'
    assert_response :success
  end

  def test_create
    delete :destroy, :room_id => Room.first.id, :id => 'a_user_in_room_1'
    assert_response :success
  end

end
