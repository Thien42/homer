require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:controllerProjectTestOne)
    @projectDestroy = projects(:controllerProjectTestDestroy)
/    @myConnection = User.create(email: "thienan.lacape@epitech.eu", password: Devise::Encryptor.digest(User, "helloworld"))
    @project.user = @myConnection
    @project.save
    /
  end

  test "test one" do
    get "/"
    assert_response :success
  end

  end
