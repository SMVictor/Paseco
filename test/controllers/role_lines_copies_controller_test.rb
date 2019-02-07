require 'test_helper'

class RoleLinesCopiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role_lines_copy = role_lines_copies(:one)
  end

  test "should get index" do
    get role_lines_copies_url
    assert_response :success
  end

  test "should get new" do
    get new_role_lines_copy_url
    assert_response :success
  end

  test "should create role_lines_copy" do
    assert_difference('RoleLinesCopy.count') do
      post role_lines_copies_url, params: { role_lines_copy: {  } }
    end

    assert_redirected_to role_lines_copy_url(RoleLinesCopy.last)
  end

  test "should show role_lines_copy" do
    get role_lines_copy_url(@role_lines_copy)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_lines_copy_url(@role_lines_copy)
    assert_response :success
  end

  test "should update role_lines_copy" do
    patch role_lines_copy_url(@role_lines_copy), params: { role_lines_copy: {  } }
    assert_redirected_to role_lines_copy_url(@role_lines_copy)
  end

  test "should destroy role_lines_copy" do
    assert_difference('RoleLinesCopy.count', -1) do
      delete role_lines_copy_url(@role_lines_copy)
    end

    assert_redirected_to role_lines_copies_url
  end
end
