require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should success signup" do
    assert_difference('User.count') do
      post :signup, {"username" => "new_user",
                     "password" => "valid_password"},
                     format: "json"
      assert_response :success
      body = JSON.parse(response.body)
      assert body["user_name"] == "new_user"
      assert body["login_count"] == 1
    end

    assert_no_difference('User.count') do
      post :signup, {"username" => "new_user",
                     "password" => "valid_password"},
                     format: "json"
      assert_response :success
      body = JSON.parse(response.body)
      assert body["error_code"] = -3  # duplicate username
    end
  end

  test "should failed signup" do
    assert_no_difference('User.count') do
      post :signup, {"username" => "too_long_username_to_signup_so_must_failed",
                     "password" => "valid_password"},
                     format: "json"
      assert_response :success
      body = JSON.parse(response.body)
      assert body["error_code"] = -1  # username length is execeed to limit
    end

    assert_no_difference('User.count') do
      post :signup, {"username" => "new_user",
                     "password" => "too_long_pasword_to_signup_so_must_failed"},
                     format: "json"
      assert_response :success
      body = JSON.parse(response.body)
      assert body["error_code"] = -2  # password length is execeed to limit
    end

    assert_no_difference('User.count') do
      post :signup, {"username" => "user1",
                     "password" => "valid_password"},
                     format: "json"
      assert_response :success
      body = JSON.parse(response.body)
      assert body["error_code"] = -3  # duplicate username
    end
  end

  test "should get login" do
    get :login
    assert_response :success
  end

end
