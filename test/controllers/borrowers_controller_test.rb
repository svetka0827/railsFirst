require 'test_helper'

class BorrowersControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end