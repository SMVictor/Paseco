require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    @quote = quotes(:one)
  end

  test "visiting the index" do
    visit quotes_url
    assert_selector "h1", text: "Quotes"
  end

  test "creating a Quote" do
    visit quotes_url
    click_on "New Quote"

    fill_in "Holidays", with: @quote.holidays
    fill_in "Institution", with: @quote.institution
    fill_in "Officers", with: @quote.officers
    fill_in "Payment", with: @quote.payment_id
    fill_in "Procedure description", with: @quote.procedure_description
    fill_in "Procedure number", with: @quote.procedure_number
    fill_in "Salary", with: @quote.salary
    fill_in "Type", with: @quote.type
    fill_in "Vacations", with: @quote.vacations
    click_on "Create Quote"

    assert_text "Quote was successfully created"
    click_on "Back"
  end

  test "updating a Quote" do
    visit quotes_url
    click_on "Edit", match: :first

    fill_in "Holidays", with: @quote.holidays
    fill_in "Institution", with: @quote.institution
    fill_in "Officers", with: @quote.officers
    fill_in "Payment", with: @quote.payment_id
    fill_in "Procedure description", with: @quote.procedure_description
    fill_in "Procedure number", with: @quote.procedure_number
    fill_in "Salary", with: @quote.salary
    fill_in "Type", with: @quote.type
    fill_in "Vacations", with: @quote.vacations
    click_on "Update Quote"

    assert_text "Quote was successfully updated"
    click_on "Back"
  end

  test "destroying a Quote" do
    visit quotes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Quote was successfully destroyed"
  end
end
