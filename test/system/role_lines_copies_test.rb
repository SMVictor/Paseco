require "application_system_test_case"

class RoleLinesCopiesTest < ApplicationSystemTestCase
  setup do
    @role_lines_copy = role_lines_copies(:one)
  end

  test "visiting the index" do
    visit role_lines_copies_url
    assert_selector "h1", text: "Role Lines Copies"
  end

  test "creating a Role lines copy" do
    visit role_lines_copies_url
    click_on "New Role Lines Copy"

    click_on "Create Role lines copy"

    assert_text "Role lines copy was successfully created"
    click_on "Back"
  end

  test "updating a Role lines copy" do
    visit role_lines_copies_url
    click_on "Edit", match: :first

    click_on "Update Role lines copy"

    assert_text "Role lines copy was successfully updated"
    click_on "Back"
  end

  test "destroying a Role lines copy" do
    visit role_lines_copies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Role lines copy was successfully destroyed"
  end
end
