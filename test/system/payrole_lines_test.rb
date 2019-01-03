require "application_system_test_case"

class PayroleLinesTest < ApplicationSystemTestCase
  setup do
    @payrole_line = payrole_lines(:one)
  end

  test "visiting the index" do
    visit payrole_lines_url
    assert_selector "h1", text: "Payrole Lines"
  end

  test "creating a Payrole line" do
    visit payrole_lines_url
    click_on "New Payrole Line"

    fill_in "Ccss Deduction", with: @payrole_line.ccss_deduction
    fill_in "Deductions", with: @payrole_line.deductions
    fill_in "Extra Hours", with: @payrole_line.extra_hours
    fill_in "Extra Payments", with: @payrole_line.extra_payments
    fill_in "Gross Salary", with: @payrole_line.gross_salary
    fill_in "Min Salary", with: @payrole_line.min_salary
    fill_in "Net Salary", with: @payrole_line.net_salary
    click_on "Create Payrole line"

    assert_text "Payrole line was successfully created"
    click_on "Back"
  end

  test "updating a Payrole line" do
    visit payrole_lines_url
    click_on "Edit", match: :first

    fill_in "Ccss Deduction", with: @payrole_line.ccss_deduction
    fill_in "Deductions", with: @payrole_line.deductions
    fill_in "Extra Hours", with: @payrole_line.extra_hours
    fill_in "Extra Payments", with: @payrole_line.extra_payments
    fill_in "Gross Salary", with: @payrole_line.gross_salary
    fill_in "Min Salary", with: @payrole_line.min_salary
    fill_in "Net Salary", with: @payrole_line.net_salary
    click_on "Update Payrole line"

    assert_text "Payrole line was successfully updated"
    click_on "Back"
  end

  test "destroying a Payrole line" do
    visit payrole_lines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payrole line was successfully destroyed"
  end
end
