require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    
  end

  test "get projects" do
    get "/"
    assert_response :success
    get "/projects/finished"
    assert_response :success
    get "/projects"
    assert_response :success
  end

  test "get project id" do
    for i in 0...7
      get "/projects/" + i.to_s
      assert_response :success
    end
    get "/projects/43"
    assert_response :missing
    get "/projects/-34"
    assert_response :missing
    get "/projects/8"
    assert_response :missing
    get "/projects/7"
    assert_response :missing
    get "/projects/7"
    assert_response :missing
    get "/projects/4342343243"
    assert_response :missing
  end

  test "get some routes" do
    get "/projects/new"
    assert_response :success

    get "/projects/0/edit"
    assert_response :success

    # Route incorreect
    get "/projects/1/edit"
    assert_response :missing

    get "/projects/434334234/edit"
    assert_response :missing
  end

  test "delete project" do
    project = projects(:projectTest2)
    delete project_url(project)
    '
    delete "/projects",
      params: { id: "2" }
    assert_response :success
    '
    get "/projects/2"
    assert_response :missing
  end
  
  '''
  test "create project" do
    post "/projects",
      params: { project: {
        name: "Test create", description: "little description", spices: "3",
        objectives_attributes: [
          {id: "0", date: "2016-03-10", description: "des", objective_type: "0"},
          {id: "1", date: "2016-03-10", description: "des", objective_type: "1"},
          {id: "2", date: "2016-03-10", description: "des", objective_type: "1"}
        ]
        }
      }
      assert_response :success
  end
'''
'''
  test "test send spice" do
    post "/projects/0/send_spices",
      params: {name: "Good luck", spices: "5", id: "0"}
    assert_response :success
  end
  '''
end
