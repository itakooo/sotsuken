require 'test_helper'

class UniSubjectsControllerTest < ActionController::TestCase
  setup do
    @uni_subject = uni_subjects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uni_subjects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uni_subject" do
    assert_difference('UniSubject.count') do
      post :create, uni_subject: @uni_subject.attributes
    end

    assert_redirected_to uni_subject_path(assigns(:uni_subject))
  end

  test "should show uni_subject" do
    get :show, id: @uni_subject
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uni_subject
    assert_response :success
  end

  test "should update uni_subject" do
    put :update, id: @uni_subject, uni_subject: @uni_subject.attributes
    assert_redirected_to uni_subject_path(assigns(:uni_subject))
  end

  test "should destroy uni_subject" do
    assert_difference('UniSubject.count', -1) do
      delete :destroy, id: @uni_subject
    end

    assert_redirected_to uni_subjects_path
  end
end
