require 'test_helper'

class EmpSelectionsControllerTest < ActionController::TestCase
  setup do
    @emp_selection = emp_selections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emp_selections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emp_selection" do
    assert_difference('EmpSelection.count') do
      post :create, emp_selection: @emp_selection.attributes
    end

    assert_redirected_to emp_selection_path(assigns(:emp_selection))
  end

  test "should show emp_selection" do
    get :show, id: @emp_selection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emp_selection
    assert_response :success
  end

  test "should update emp_selection" do
    put :update, id: @emp_selection, emp_selection: @emp_selection.attributes
    assert_redirected_to emp_selection_path(assigns(:emp_selection))
  end

  test "should destroy emp_selection" do
    assert_difference('EmpSelection.count', -1) do
      delete :destroy, id: @emp_selection
    end

    assert_redirected_to emp_selections_path
  end
end
