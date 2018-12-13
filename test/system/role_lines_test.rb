require "application_system_test_case"

class RoleLinesTest < ApplicationSystemTestCase
  setup do
    @role_line = role_lines(:one)
  end

  test "visiting the index" do
    visit role_lines_url
    assert_selector "h1", text: "Role Lines"
  end

  test "creating a Role line" do
    visit role_lines_url
    click_on "New Role Line"

    fill_in "Date", with: @role_line.date
    fill_in "Extra Hours", with: @role_line.extra_hours
    fill_in "Shift", with: @role_line.shift
    fill_in "Substall", with: @role_line.substall
    click_on "Create Role line"

    assert_text "Role line was successfully created"
    click_on "Back"
  end

  test "updating a Role line" do
    visit role_lines_url
    click_on "Edit", match: :first

    fill_in "Date", with: @role_line.date
    fill_in "Extra Hours", with: @role_line.extra_hours
    fill_in "Shift", with: @role_line.shift
    fill_in "Substall", with: @role_line.substall
    click_on "Update Role line"

    assert_text "Role line was successfully updated"
    click_on "Back"
  end

  test "destroying a Role line" do
    visit role_lines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Role line was successfully destroyed"
  end
end
