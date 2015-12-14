require 'test_helper'

class RoomLogsControllerTest < ActionController::TestCase

  def test_index
    get :index, :format => :json
    assert_response :success

    json = JSON.parse(@response.body)
    assert json.is_a?(Array)
    assert_equal RoomLog.count, json.length
  end

end
