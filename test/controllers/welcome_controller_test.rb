require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get welcome_home_url
    assert_response :success
  end

  test "not_logged in cant access index" do
    get root_url
    assert_response :found
  end

  test "logged in can access index" do
    sign_in(teachers(:diego))
    get root_url
    assert_response :success
  end

end
