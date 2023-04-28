require "test_helper"

class PromptProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get :index" do
    get prompt_projects_: index_url
    assert_response :success
  end
end
