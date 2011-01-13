require 'test_helper'

class SipAccountCodecsControllerTest < ActionController::TestCase
  setup do
    @sip_account_codec = Factory.create(:sip_account_codec)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sip_account_codecs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sip_account_codec" do
    assert_difference('SipAccountCodec.count') do
      post :create, :sip_account_codec => @sip_account_codec.attributes
    end

    assert_redirected_to sip_account_codec_path(assigns(:sip_account_codec))
  end

  test "should show sip_account_codec" do
    get :show, :id => @sip_account_codec.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sip_account_codec.to_param
    assert_response :success
  end

  test "should update sip_account_codec" do
    put :update, :id => @sip_account_codec.to_param, :sip_account_codec => @sip_account_codec.attributes
    assert_redirected_to sip_account_codec_path(assigns(:sip_account_codec))
  end

  test "should destroy sip_account_codec" do
    assert_difference('SipAccountCodec.count', -1) do
      delete :destroy, :id => @sip_account_codec.to_param
    end

    assert_redirected_to sip_account_codecs_path
  end
end
