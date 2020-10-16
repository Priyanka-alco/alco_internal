require 'test_helper'

class GstsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gst = gsts(:one)
  end

  test "should get index" do
    get gsts_url
    assert_response :success
  end

  test "should get new" do
    get new_gst_url
    assert_response :success
  end

  test "should create gst" do
    assert_difference('Gst.count') do
      post gsts_url, params: { gst: { category: @gst.category, gst_percentage: @gst.gst_percentage, status: @gst.status } }
    end

    assert_redirected_to gst_url(Gst.last)
  end

  test "should show gst" do
    get gst_url(@gst)
    assert_response :success
  end

  test "should get edit" do
    get edit_gst_url(@gst)
    assert_response :success
  end

  test "should update gst" do
    patch gst_url(@gst), params: { gst: { category: @gst.category, gst_percentage: @gst.gst_percentage, status: @gst.status } }
    assert_redirected_to gst_url(@gst)
  end

  test "should destroy gst" do
    assert_difference('Gst.count', -1) do
      delete gst_url(@gst)
    end

    assert_redirected_to gsts_url
  end
end
