require 'test_helper'

class LogsControllerTest < ActionController::TestCase

  def test_index
    get :index, :room_id => Room.first.id
    assert_response :success

    json = JSON.parse(@response.body)
    assert json.is_a?(Array)
    assert_equal RoomLog.count, json.length
  end

  def test_create
    post :create, :room_id => Room.first.id, :name => 'Tarou', :message => 'hello'
    assert_response :created
  end

end
