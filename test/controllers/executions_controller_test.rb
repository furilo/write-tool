require "test_helper"

class ExecutionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get executions_create_url
    assert_response :success
  end
end
