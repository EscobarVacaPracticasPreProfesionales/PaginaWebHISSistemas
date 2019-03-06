require 'test_helper'

class UsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get us_index_url
    assert_response :success
  end

end
