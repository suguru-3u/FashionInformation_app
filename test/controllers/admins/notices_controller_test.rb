require 'test_helper'

class Admins::NoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_notices_index_url
    assert_response :success
  end

  test "should get edit" do
    get admins_notices_edit_url
    assert_response :success
  end

end
