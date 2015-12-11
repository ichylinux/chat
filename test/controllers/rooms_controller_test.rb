require 'test_helper'

class RoomsControllerTest < ActionController::TestCase

  def test_index
    get :index, :format => :json
    assert_response :success
  end

end
