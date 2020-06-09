require 'test_helper'

class Admins::AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admins_admins_show_url
    assert_response :success
  end

end
