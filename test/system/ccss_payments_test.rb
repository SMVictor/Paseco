require "application_system_test_case"

class CcssPaymentsTest < ApplicationSystemTestCase
  setup do
    @ccss_payment = ccss_payments(:one)
  end

  test "visiting the index" do
    visit ccss_payments_url
    assert_selector "h1", text: "Ccss Payments"
  end

  test "creating a Ccss payment" do
    visit ccss_payments_url
    click_on "New Ccss Payment"

    fill_in "Amount", with: @ccss_payment.amount
    fill_in "Percentage", with: @ccss_payment.percentage
    click_on "Create Ccss payment"

    assert_text "Ccss payment was successfully created"
    click_on "Back"
  end

  test "updating a Ccss payment" do
    visit ccss_payments_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @ccss_payment.amount
    fill_in "Percentage", with: @ccss_payment.percentage
    click_on "Update Ccss payment"

    assert_text "Ccss payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Ccss payment" do
    visit ccss_payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ccss payment was successfully destroyed"
  end
end
