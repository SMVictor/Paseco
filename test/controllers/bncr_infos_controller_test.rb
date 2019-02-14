require 'test_helper'

class BncrInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bncr_info = bncr_infos(:one)
  end

  test "should get index" do
    get bncr_infos_url
    assert_response :success
  end

  test "should get new" do
    get new_bncr_info_url
    assert_response :success
  end

  test "should create bncr_info" do
    assert_difference('BncrInfo.count') do
      post bncr_infos_url, params: { bncr_info: { account: @bncr_info.account, company: @bncr_info.company, concept: @bncr_info.concept, consecutive: @bncr_info.consecutive, date: @bncr_info.date, transfer_type: @bncr_info.transfer_type } }
    end

    assert_redirected_to bncr_info_url(BncrInfo.last)
  end

  test "should show bncr_info" do
    get bncr_info_url(@bncr_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_bncr_info_url(@bncr_info)
    assert_response :success
  end

  test "should update bncr_info" do
    patch bncr_info_url(@bncr_info), params: { bncr_info: { account: @bncr_info.account, company: @bncr_info.company, concept: @bncr_info.concept, consecutive: @bncr_info.consecutive, date: @bncr_info.date, transfer_type: @bncr_info.transfer_type } }
    assert_redirected_to bncr_info_url(@bncr_info)
  end

  test "should destroy bncr_info" do
    assert_difference('BncrInfo.count', -1) do
      delete bncr_info_url(@bncr_info)
    end

    assert_redirected_to bncr_infos_url
  end
end
