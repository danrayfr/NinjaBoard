require "test_helper"

class LeaderboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get leaderboards_index_url
    assert_response :success
  end
end
