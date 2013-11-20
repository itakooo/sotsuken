require 'test_helper'

class UniReasonsControllerTest < ActionController::TestCase
  setup do
    @uni_reason = uni_reasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uni_reasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uni_reason" do
    assert_difference('UniReason.count') do
      post :create, uni_reason: @uni_reason.attributes
    end

    assert_redirected_to uni_reason_path(assigns(:uni_reason))
  end

  test "should show uni_reason" do
    get :show, id: @uni_reason
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uni_reason
    assert_response :success
  end

  test "should update uni_reason" do
    put :update, id: @uni_reason, uni_reason: @uni_reason.attributes
    assert_redirected_to uni_reason_path(assigns(:uni_reason))
  end

  test "should destroy uni_reason" do
    assert_difference('UniReason.count', -1) do
      delete :destroy, id: @uni_reason
    end

    assert_redirected_to uni_reasons_path
  end
end
