require 'test_helper'

class UserCommentRatingControllerTest < ActionController::TestCase
  test "should get rateit" do
    get :rateit
    assert_response :success
  end

end
