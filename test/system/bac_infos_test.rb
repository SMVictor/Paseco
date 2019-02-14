require "application_system_test_case"

class BacInfosTest < ApplicationSystemTestCase
  setup do
    @bac_info = bac_infos(:one)
  end

  test "visiting the index" do
    visit bac_infos_url
    assert_selector "h1", text: "Bac Infos"
  end

  test "creating a Bac info" do
    visit bac_infos_url
    click_on "New Bac Info"

    fill_in "Concept", with: @bac_info.concept
    fill_in "Date", with: @bac_info.date
    fill_in "Plan", with: @bac_info.plan
    fill_in "Shipping", with: @bac_info.shipping
    click_on "Create Bac info"

    assert_text "Bac info was successfully created"
    click_on "Back"
  end

  test "updating a Bac info" do
    visit bac_infos_url
    click_on "Edit", match: :first

    fill_in "Concept", with: @bac_info.concept
    fill_in "Date", with: @bac_info.date
    fill_in "Plan", with: @bac_info.plan
    fill_in "Shipping", with: @bac_info.shipping
    click_on "Update Bac info"

    assert_text "Bac info was successfully updated"
    click_on "Back"
  end

  test "destroying a Bac info" do
    visit bac_infos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bac info was successfully destroyed"
  end
end
