require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:controllerProjectTestOne)
    @projectDestroy = projects(:controllerProjectTestDestroy)
    @myConnection = User.create(email: "thienan.lacape@epitech.eu", password: Devise::Encryptor.digest(User, "helloworld"))
    @project.user = @myConnection
    @project.save
  end

  test "signed in user is redirected to root_path" do
    get user_session_path
    assert_equal 200, status
    post user_session_path, 'user[email]' => @myConnection.email, 'user[password]' =>  @myConnection.password
    follow_redirect!
    assert_equal 200, status
    assert_equal "/", path
  end

  test "user is redirected to sign in page when visiting home page" do
    get "/"
    assert_equal 302, status
    follow_redirect!
    assert_equal "/users/sign_in", path
    assert_equal 200, status
  end
  
  def connection
    get user_session_path
    assert_equal 200, status
    post user_session_path, 'user[email]' => @myConnection.email, 'user[password]' =>  @myConnection.password
    follow_redirect!
  end

  test "should get new" do
    connection
    get new_project_url
    assert_response :success
  end

  test "should create project" do
    connection
    assert_difference('Project.count') do
      post projects_url, params: { project: { description: @project.description, name: @project.name, spices: @project.spices } }
    end

    assert_redirected_to project_url(Project.last)
  end

  test "should show project" do
    connection
    get project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    connection
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    connection
    put project_url(@project), params: { project: { description: "new description", name: "new name", spices: 33 } }
    assert_response :success ## Redirection pourquoi ??
    assert_equal @project.description, "new description"
    assert_equal @project.name, "new name"
    assert_equal @project.name, 33
  end

  test "should destroy project" do
    connection
    delete project_url(@projectDestroy)
    assert_response :success
  end

  # test "test status" do
  #
  # end
end
