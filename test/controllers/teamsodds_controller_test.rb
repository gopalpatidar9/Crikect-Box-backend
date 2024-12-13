require "test_helper"

class TeamsoddsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teamsodds_index_url
    assert_response :success
  end
end
