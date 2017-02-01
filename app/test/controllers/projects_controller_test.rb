require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:controllerProjectTestOne)
    @projectDestroy = projects(:controllerProjectTestDestroy)
  end

  test "get projects" do
    get "/"
    assert_response :success
    get "/projects/finished"
    assert_response :success
  end

end
