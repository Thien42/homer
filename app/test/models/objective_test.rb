require 'test_helper'

class ObjectiveTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "validation function" do
    obj = objectives(:objectiveTest)

    assert 1 == obj.get_valid_objectives, "Error objectif valide"
    assert 2 == obj.get_total_objectives, "Error total objectif test 1"

    us = users(:objectiveTest)
    objFund = ObjectiveValidation.new(objective: obj, user: us)
    objFund.save

    assert 3 == obj.get_total_objectives, "Error total objectif after save objectiveValidation"

    objFund.passed = true
    objFund.save
    assert 2 == obj.get_valid_objectives, "Error valide objective after modification objectiveValidation"
    assert 3 == obj.get_total_objectives, "Error number objective validation"

    objFundPassed = objective_validations(:objectiveTestOne)
    objFundPassed.passed = true
    objFundPassed.save

    assert 3 == obj.get_valid_objectives
    assert 3 == obj.get_total_objectives
  end
end
