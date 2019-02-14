require 'test_helper'

class BacInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bac_info = bac_infos(:one)
  end

  test "should get index" do
    get bac_infos_url
    assert_response :success
  end

  test "should get new" do
    get new_bac_info_url
    assert_response :success
  end

  test "should create bac_info" do
    assert_difference('BacInfo.count') do
      post bac_infos_url, params: { bac_info: { concept: @bac_info.concept, date: @bac_info.date, plan: @bac_info.plan, shipping: @bac_info.shipping } }
    end

    assert_redirected_to bac_info_url(BacInfo.last)
  end

  test "should show bac_info" do
    get bac_info_url(@bac_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_bac_info_url(@bac_info)
    assert_response :success
  end

  test "should update bac_info" do
    patch bac_info_url(@bac_info), params: { bac_info: { concept: @bac_info.concept, date: @bac_info.date, plan: @bac_info.plan, shipping: @bac_info.shipping } }
    assert_redirected_to bac_info_url(@bac_info)
  end

  test "should destroy bac_info" do
    assert_difference('BacInfo.count', -1) do
      delete bac_info_url(@bac_info)
    end

    assert_redirected_to bac_infos_url
  end
end
