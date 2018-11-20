require "application_system_test_case"

class StallsTest < ApplicationSystemTestCase
  setup do
    @stall = stalls(:one)
  end

  test "visiting the index" do
    visit stalls_url
    assert_selector "h1", text: "Stalls"
  end

  test "creating a Stall" do
    visit stalls_url
    click_on "New Stall"

    fill_in "Description", with: @stall.description
    fill_in "Name", with: @stall.name
    click_on "Create Stall"

    assert_text "Stall was successfully created"
    click_on "Back"
  end

  test "updating a Stall" do
    visit stalls_url
    click_on "Edit", match: :first

    fill_in "Description", with: @stall.description
    fill_in "Name", with: @stall.name
    click_on "Update Stall"

    assert_text "Stall was successfully updated"
    click_on "Back"
  end

  test "destroying a Stall" do
    visit stalls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stall was successfully destroyed"
  end
end
