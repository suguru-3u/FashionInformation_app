require 'test_helper'

class Users::NotesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_notes_index_url
    assert_response :success
  end

end
