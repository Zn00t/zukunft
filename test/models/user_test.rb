require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  test "receive_money crashes with invalid users" do
    test_user = users(:one)
    old_value = test_user.food
    test_user.receive_money!(amount: 100, from: 1234)
    assert_equal(old_value, test_user.food)
  end

  test "receive_money transfers money from another user" do
    test_user = users(:one)
    user2 = users(:two)
    test_user.receive_money!(amount: 100, from: user2.id)
    user2.reload
    assert_equal(100, test_user.food)
    assert_equal(200, user2.food)
  end
end
