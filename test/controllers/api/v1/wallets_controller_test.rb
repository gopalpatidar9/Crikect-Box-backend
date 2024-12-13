require "test_helper"

class Api::V1::WalletsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_wallets_index_url
    assert_response :success
  end
end
