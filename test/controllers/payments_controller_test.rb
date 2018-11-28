require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = payments(:one)
  end

  test "should get index" do
    get payments_url
    assert_response :success
  end

  test "should get new" do
    get new_payment_url
    assert_response :success
  end

  test "should create payment" do
    assert_difference('Payment.count') do
      post payments_url, params: { payment: { daytime: @payment.daytime, daytime_cost: @payment.daytime_cost, description: @payment.description, extra_: @payment.extra_, extra_daytime: @payment.extra_daytime, extra_daytime_cost: @payment.extra_daytime_cost, extra_mixedtime: @payment.extra_mixedtime, mixedtime: @payment.mixedtime, mixedtime_cost: @payment.mixedtime_cost, name: @payment.name, nighttime: @payment.nighttime, nighttime_cost: @payment.nighttime_cost } }
    end

    assert_redirected_to payment_url(Payment.last)
  end

  test "should show payment" do
    get payment_url(@payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_url(@payment)
    assert_response :success
  end

  test "should update payment" do
    patch payment_url(@payment), params: { payment: { daytime: @payment.daytime, daytime_cost: @payment.daytime_cost, description: @payment.description, extra_: @payment.extra_, extra_daytime: @payment.extra_daytime, extra_daytime_cost: @payment.extra_daytime_cost, extra_mixedtime: @payment.extra_mixedtime, mixedtime: @payment.mixedtime, mixedtime_cost: @payment.mixedtime_cost, name: @payment.name, nighttime: @payment.nighttime, nighttime_cost: @payment.nighttime_cost } }
    assert_redirected_to payment_url(@payment)
  end

  test "should destroy payment" do
    assert_difference('Payment.count', -1) do
      delete payment_url(@payment)
    end

    assert_redirected_to payments_url
  end
end
