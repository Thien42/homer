require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  /
  test "should start whitout spices" do
    project = Project.new
    assert project.get_funded_spices == 0
  end

  test "add project funding and count" do
    project = Project.new(name: "test", description: "description", spices: 0)
    userTest = User.new(:email => 'test.de@epitech.eu', :password => 'password', :password_confirmation => 'password')
    assert userTest.save, "Error create userTest"
    funding = ProjectFunding.new(user: userTest, project: project, spices: 5, comment: "test")
    assert funding.save, "Error first funding"
    assert 0 == project.get_funded_spices, "Error on get_funded_spices, not validate by admin"
    project.status = 2
    project.save
    assert 'kick_off_start' == project.status, "Error status not kick_off_start is not 2"
    funding = ProjectFunding.new(user: userTest, project: project, spices: 5, comment: "test")
    assert funding.save, "Error funding project"
    assert 5 == project.get_funded_spices, "Error on get_funded_spices"
    funding = ProjectFunding.new(user: userTest, project: project, spices: 15, comment: "test")
    funding.save
    assert 20 == project.get_funded_spices, "Error on get_funded_spices"
    funding = ProjectFunding.new(user: userTest, project: project, spices: 5, comment: "test")
    funding.save
    assert 25 == project.get_funded_spices, "Error on get_funded_spices"
    funding = ProjectFunding.new(user: userTest, project: project, spices: 15, comment: "test")
    funding.save
    assert_equal 40, project.get_funded_spices, "Error on get_funded_spices"
  end

  test "yml project access" do
    project = projects(:projectTestOne)
    assert 0 == project.get_funded_spices, "Error spices should be 0"
    assert 'pending' == project.status, "Error on default status"

    projectTwo = projects(:projectTestTwo)
    assert 30 != projectTwo.get_funded_spices, "Error status is less then 3"
    assert 'confirmed_by_admin' == projectTwo.status

    projectThree = projects(:projectTestThree)
    assert 30 == projectThree.get_funded_spices, "Error status is validate"
    assert 'kick_off_validated' == projectThree.status
  end
  /
end
