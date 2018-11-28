require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase
  setup do
    @payment = payments(:one)
  end

  test "visiting the index" do
    visit payments_url
    assert_selector "h1", text: "Payments"
  end

  test "creating a Payment" do
    visit payments_url
    click_on "New Payment"

    fill_in "Daytime", with: @payment.daytime
    fill_in "Daytime Cost", with: @payment.daytime_cost
    fill_in "Description", with: @payment.description
    fill_in "Extra ", with: @payment.extra_
    fill_in "Extra Daytime", with: @payment.extra_daytime
    fill_in "Extra Daytime Cost", with: @payment.extra_daytime_cost
    fill_in "Extra Mixedtime", with: @payment.extra_mixedtime
    fill_in "Mixedtime", with: @payment.mixedtime
    fill_in "Mixedtime Cost", with: @payment.mixedtime_cost
    fill_in "Name", with: @payment.name
    fill_in "Nighttime", with: @payment.nighttime
    fill_in "Nighttime Cost", with: @payment.nighttime_cost
    click_on "Create Payment"

    assert_text "Payment was successfully created"
    click_on "Back"
  end

  test "updating a Payment" do
    visit payments_url
    click_on "Edit", match: :first

    fill_in "Daytime", with: @payment.daytime
    fill_in "Daytime Cost", with: @payment.daytime_cost
    fill_in "Description", with: @payment.description
    fill_in "Extra ", with: @payment.extra_
    fill_in "Extra Daytime", with: @payment.extra_daytime
    fill_in "Extra Daytime Cost", with: @payment.extra_daytime_cost
    fill_in "Extra Mixedtime", with: @payment.extra_mixedtime
    fill_in "Mixedtime", with: @payment.mixedtime
    fill_in "Mixedtime Cost", with: @payment.mixedtime_cost
    fill_in "Name", with: @payment.name
    fill_in "Nighttime", with: @payment.nighttime
    fill_in "Nighttime Cost", with: @payment.nighttime_cost
    click_on "Update Payment"

    assert_text "Payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Payment" do
    visit payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payment was successfully destroyed"
  end
end
