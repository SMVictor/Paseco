require 'test_helper'

class CcssPaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ccss_payment = ccss_payments(:one)
  end

  test "should get index" do
    get ccss_payments_url
    assert_response :success
  end

  test "should get new" do
    get new_ccss_payment_url
    assert_response :success
  end

  test "should create ccss_payment" do
    assert_difference('CcssPayment.count') do
      post ccss_payments_url, params: { ccss_payment: { amount: @ccss_payment.amount, percentage: @ccss_payment.percentage } }
    end

    assert_redirected_to ccss_payment_url(CcssPayment.last)
  end

  test "should show ccss_payment" do
    get ccss_payment_url(@ccss_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_ccss_payment_url(@ccss_payment)
    assert_response :success
  end

  test "should update ccss_payment" do
    patch ccss_payment_url(@ccss_payment), params: { ccss_payment: { amount: @ccss_payment.amount, percentage: @ccss_payment.percentage } }
    assert_redirected_to ccss_payment_url(@ccss_payment)
  end

  test "should destroy ccss_payment" do
    assert_difference('CcssPayment.count', -1) do
      delete ccss_payment_url(@ccss_payment)
    end

    assert_redirected_to ccss_payments_url
  end
end
