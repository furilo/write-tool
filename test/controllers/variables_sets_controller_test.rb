require "test_helper"

class VariablesSetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get variables_sets_index_url
    assert_response :success
  end

  test "should get create" do
    get variables_sets_create_url
    assert_response :success
  end

  test "should get edit" do
    get variables_sets_edit_url
    assert_response :success
  end

  test "should get update" do
    get variables_sets_update_url
    assert_response :success
  end
end
