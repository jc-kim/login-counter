require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "username length has limit" do
    user = User.new(username: "valid_username", password: "valid_password")
    assert user.valid?

    user1 = User.new(username: "shrt", password: "valid_password")
    assert not(user1.valid?)
    assert user1.error_code == -1

    user2 = User.new(username: "that username is too long so it's invalid", password: "valid_password")
    assert not(user1.valid?)
    assert user1.error_code == -1
  end

  test "username should be unique" do
    user1 = User.new(username: "user1", password: "valid_password")
    assert not(user1.valid?)
    assert user1.error_code == -3
  end

  test "password length has limit" do
    user = User.new(username: "validuser", "password": "inva")
    assert not(user.valid?)
    assert user.error_code == -2
  end
end
