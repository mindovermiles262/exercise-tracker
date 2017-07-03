require 'test_helper'

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get exercises_create_url
    assert_response :success
  end

end
