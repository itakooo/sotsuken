require 'test_helper'

class UniInterviewsControllerTest < ActionController::TestCase
  setup do
    @uni_interview = uni_interviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uni_interviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uni_interview" do
    assert_difference('UniInterview.count') do
      post :create, uni_interview: @uni_interview.attributes
    end

    assert_redirected_to uni_interview_path(assigns(:uni_interview))
  end

  test "should show uni_interview" do
    get :show, id: @uni_interview
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uni_interview
    assert_response :success
  end

  test "should update uni_interview" do
    put :update, id: @uni_interview, uni_interview: @uni_interview.attributes
    assert_redirected_to uni_interview_path(assigns(:uni_interview))
  end

  test "should destroy uni_interview" do
    assert_difference('UniInterview.count', -1) do
      delete :destroy, id: @uni_interview
    end

    assert_redirected_to uni_interviews_path
  end
end
