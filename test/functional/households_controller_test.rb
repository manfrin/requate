require 'test_helper'

class HouseholdsControllerTest < ActionController::TestCase
  setup do
    @household = households(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:households)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create household" do
    assert_difference('Household.count') do
      post :create, household: { address_entry_id: @household.address_entry_id, household_bill_id: @household.household_bill_id, household_member_id: @household.household_member_id, household_name: @household.household_name, household_regular_bill_id: @household.household_regular_bill_id }
    end

    assert_redirected_to household_path(assigns(:household))
  end

  test "should show household" do
    get :show, id: @household
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @household
    assert_response :success
  end

  test "should update household" do
    put :update, id: @household, household: { address_entry_id: @household.address_entry_id, household_bill_id: @household.household_bill_id, household_member_id: @household.household_member_id, household_name: @household.household_name, household_regular_bill_id: @household.household_regular_bill_id }
    assert_redirected_to household_path(assigns(:household))
  end

  test "should destroy household" do
    assert_difference('Household.count', -1) do
      delete :destroy, id: @household
    end

    assert_redirected_to households_path
  end
end
