require "test_helper"

class Api::V1::LiveOddsControllerTest < ActionDispatch::IntegrationTest
  test "should get team_a_odds" do
    get api_v1_live_odds_team_a_odds_url
    assert_response :success
  end

  test "should get team_b_odds" do
    get api_v1_live_odds_team_b_odds_url
    assert_response :success
  end
end
