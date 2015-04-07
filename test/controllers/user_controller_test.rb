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

  test "should success login" do
    post :login, {"username" => "user1",
                  "password" => "user!password"},
                  format: "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "user1", body["user_name"]
    assert_equal 2, body["login_count"]
  end

  test "should failed login" do
    post :login, {"username" => "user1",
                  "password" => "user1password"},
                  format: "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal -4, body["error_code"]
  end
end
