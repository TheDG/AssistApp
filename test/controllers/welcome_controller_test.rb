require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get welcome_home_url
    assert_response :success
  end

  test "not_logged in cant access index" do
    get root_url
    assert_response :unauthorized
  end

  test "logged in can access index" do
    sign_in(teachers(:jm))
    get root_url
    assert_response :success
  end

end
