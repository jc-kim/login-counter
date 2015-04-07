require 'test_helper'

class DatabaseControllerTest < ActionController::TestCase
  test "should get clearData" do
    assert_equal 2, User.all().count
    post :clearData
    assert_response :success
    assert_equal 0, User.all().count
  end

end
