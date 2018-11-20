require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:one)
  end

  test "visiting the index" do
    visit customers_url
    assert_selector "h1", text: "Customers"
  end

  test "creating a Customer" do
    visit customers_url
    click_on "New Customer"

    fill_in "Business Name", with: @customer.business_name
    fill_in "Contact", with: @customer.contact
    fill_in "Email", with: @customer.email
    fill_in "Legal Document", with: @customer.legal_document
    fill_in "Name", with: @customer.name
    fill_in "Payment Conditions", with: @customer.payment_conditions
    fill_in "Payment Method", with: @customer.payment_method
    fill_in "Phone Number", with: @customer.phone_number
    fill_in "Representative Name", with: @customer.representative_name
    fill_in "Representativr", with: @customer.representativr_id
    fill_in "Tradename", with: @customer.tradename
    click_on "Create Customer"

    assert_text "Customer was successfully created"
    click_on "Back"
  end

  test "updating a Customer" do
    visit customers_url
    click_on "Edit", match: :first

    fill_in "Business Name", with: @customer.business_name
    fill_in "Contact", with: @customer.contact
    fill_in "Email", with: @customer.email
    fill_in "Legal Document", with: @customer.legal_document
    fill_in "Name", with: @customer.name
    fill_in "Payment Conditions", with: @customer.payment_conditions
    fill_in "Payment Method", with: @customer.payment_method
    fill_in "Phone Number", with: @customer.phone_number
    fill_in "Representative Name", with: @customer.representative_name
    fill_in "Representativr", with: @customer.representativr_id
    fill_in "Tradename", with: @customer.tradename
    click_on "Update Customer"

    assert_text "Customer was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer" do
    visit customers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer was successfully destroyed"
  end
end
