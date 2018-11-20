require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get customers_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_url
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post customers_url, params: { customer: { business_name: @customer.business_name, contact: @customer.contact, email: @customer.email, legal_document: @customer.legal_document, name: @customer.name, payment_conditions: @customer.payment_conditions, payment_method: @customer.payment_method, phone_number: @customer.phone_number, representative_name: @customer.representative_name, representativr_id: @customer.representativr_id, tradename: @customer.tradename } }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should show customer" do
    get customer_url(@customer)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_url(@customer)
    assert_response :success
  end

  test "should update customer" do
    patch customer_url(@customer), params: { customer: { business_name: @customer.business_name, contact: @customer.contact, email: @customer.email, legal_document: @customer.legal_document, name: @customer.name, payment_conditions: @customer.payment_conditions, payment_method: @customer.payment_method, phone_number: @customer.phone_number, representative_name: @customer.representative_name, representativr_id: @customer.representativr_id, tradename: @customer.tradename } }
    assert_redirected_to customer_url(@customer)
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
end
