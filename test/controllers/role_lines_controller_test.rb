require 'test_helper'

class RoleLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role_line = role_lines(:one)
  end

  test "should get index" do
    get role_lines_url
    assert_response :success
  end

  test "should get new" do
    get new_role_line_url
    assert_response :success
  end

  test "should create role_line" do
    assert_difference('RoleLine.count') do
      post role_lines_url, params: { role_line: { date: @role_line.date, extra_hours: @role_line.extra_hours, shift: @role_line.shift, substall: @role_line.substall } }
    end

    assert_redirected_to role_line_url(RoleLine.last)
  end

  test "should show role_line" do
    get role_line_url(@role_line)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_line_url(@role_line)
    assert_response :success
  end

  test "should update role_line" do
    patch role_line_url(@role_line), params: { role_line: { date: @role_line.date, extra_hours: @role_line.extra_hours, shift: @role_line.shift, substall: @role_line.substall } }
    assert_redirected_to role_line_url(@role_line)
  end

  test "should destroy role_line" do
    assert_difference('RoleLine.count', -1) do
      delete role_line_url(@role_line)
    end

    assert_redirected_to role_lines_url
  end
end
