require 'test_helper'

class LogsControllerTest < ActionController::TestCase

  def test_index
    from = Time.now - 10.second
    to = Time.now + 1.second

    get :index, :room_id => Room.first.id, :datetime_from => from.strftime('%Y-%m-%d %H:%M:%S'), :datetime_to => to.strftime('%Y-%m-%d %H:%M:%S')
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
