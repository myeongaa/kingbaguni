require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get in_cart" do
    get :in_cart
    assert_response :success
  end

  test "should get purchase" do
    get :purchase
    assert_response :success
  end

end
