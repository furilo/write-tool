require "test_helper"

class AiUnitsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get ai_units_create_url
    assert_response :success
  end

  test "should get update" do
    get ai_units_update_url
    assert_response :success
  end
end
