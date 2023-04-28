require "test_helper"

class PromptPlaygroundControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get prompt_playground_show_url
    assert_response :success
  end
end
