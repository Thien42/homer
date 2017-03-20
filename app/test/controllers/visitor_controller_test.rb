require 'test_helper'

class VisitorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get visitor_index_url
    assert_response :success
  end

  test "should get show" do
    get visitor_show_url
    assert_response :success
  end

end
