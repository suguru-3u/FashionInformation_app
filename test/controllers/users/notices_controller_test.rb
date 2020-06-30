require 'test_helper'

class Users::NoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_notices_index_url
    assert_response :success
  end

  test "should get show" do
    get users_notices_show_url
    assert_response :success
  end

end
