require 'test_helper'

class PayroleLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payrole_line = payrole_lines(:one)
  end

  test "should get index" do
    get payrole_lines_url
    assert_response :success
  end

  test "should get new" do
    get new_payrole_line_url
    assert_response :success
  end

  test "should create payrole_line" do
    assert_difference('PayroleLine.count') do
      post payrole_lines_url, params: { payrole_line: { ccss_deduction: @payrole_line.ccss_deduction, deductions: @payrole_line.deductions, extra_hours: @payrole_line.extra_hours, extra_payments: @payrole_line.extra_payments, gross_salary: @payrole_line.gross_salary, min_salary: @payrole_line.min_salary, net_salary: @payrole_line.net_salary } }
    end

    assert_redirected_to payrole_line_url(PayroleLine.last)
  end

  test "should show payrole_line" do
    get payrole_line_url(@payrole_line)
    assert_response :success
  end

  test "should get edit" do
    get edit_payrole_line_url(@payrole_line)
    assert_response :success
  end

  test "should update payrole_line" do
    patch payrole_line_url(@payrole_line), params: { payrole_line: { ccss_deduction: @payrole_line.ccss_deduction, deductions: @payrole_line.deductions, extra_hours: @payrole_line.extra_hours, extra_payments: @payrole_line.extra_payments, gross_salary: @payrole_line.gross_salary, min_salary: @payrole_line.min_salary, net_salary: @payrole_line.net_salary } }
    assert_redirected_to payrole_line_url(@payrole_line)
  end

  test "should destroy payrole_line" do
    assert_difference('PayroleLine.count', -1) do
      delete payrole_line_url(@payrole_line)
    end

    assert_redirected_to payrole_lines_url
  end
end
