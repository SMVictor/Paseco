require "application_system_test_case"

class BncrInfosTest < ApplicationSystemTestCase
  setup do
    @bncr_info = bncr_infos(:one)
  end

  test "visiting the index" do
    visit bncr_infos_url
    assert_selector "h1", text: "Bncr Infos"
  end

  test "creating a Bncr info" do
    visit bncr_infos_url
    click_on "New Bncr Info"

    fill_in "Account", with: @bncr_info.account
    fill_in "Company", with: @bncr_info.company
    fill_in "Concept", with: @bncr_info.concept
    fill_in "Consecutive", with: @bncr_info.consecutive
    fill_in "Date", with: @bncr_info.date
    fill_in "Transfer type", with: @bncr_info.transfer_type
    click_on "Create Bncr info"

    assert_text "Bncr info was successfully created"
    click_on "Back"
  end

  test "updating a Bncr info" do
    visit bncr_infos_url
    click_on "Edit", match: :first

    fill_in "Account", with: @bncr_info.account
    fill_in "Company", with: @bncr_info.company
    fill_in "Concept", with: @bncr_info.concept
    fill_in "Consecutive", with: @bncr_info.consecutive
    fill_in "Date", with: @bncr_info.date
    fill_in "Transfer type", with: @bncr_info.transfer_type
    click_on "Update Bncr info"

    assert_text "Bncr info was successfully updated"
    click_on "Back"
  end

  test "destroying a Bncr info" do
    visit bncr_infos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bncr info was successfully destroyed"
  end
end
