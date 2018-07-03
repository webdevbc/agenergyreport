require 'test_helper'

class StepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @step = steps(:one)
  end

  test "should get index" do
    get steps_url
    assert_response :success
  end

  test "should get new" do
    get new_step_url
    assert_response :success
  end

  test "should create step" do
    assert_difference('Step.count') do
      post steps_url, params: { step: { category: @step.category, cost: @step.cost, energy_unit_id: @step.energy_unit_id, energy_units_used: @step.energy_units_used, name: @step.name, notes: @step.notes, slug: @step.slug, source_text: @step.source_text, source_url: @step.source_url, subcategory: @step.subcategory, type: @step.type } }
    end

    assert_redirected_to step_url(Step.last)
  end

  test "should show step" do
    get step_url(@step)
    assert_response :success
  end

  test "should get edit" do
    get edit_step_url(@step)
    assert_response :success
  end

  test "should update step" do
    patch step_url(@step), params: { step: { category: @step.category, cost: @step.cost, energy_unit_id: @step.energy_unit_id, energy_units_used: @step.energy_units_used, name: @step.name, notes: @step.notes, slug: @step.slug, source_text: @step.source_text, source_url: @step.source_url, subcategory: @step.subcategory, type: @step.type } }
    assert_redirected_to step_url(@step)
  end

  test "should destroy step" do
    assert_difference('Step.count', -1) do
      delete step_url(@step)
    end

    assert_redirected_to steps_url
  end
end
