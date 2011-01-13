require 'test_helper'

class VcardsControllerTest < ActionController::TestCase
  setup do
    @vcard = Factory.create(:vcard)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vcards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vcard" do
    assert_difference('Vcard.count') do
      post :create, :vcard => @vcard.attributes
    end

    assert_redirected_to vcard_path(assigns(:vcard))
  end

  test "should show vcard" do
    get :show, :id => @vcard.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @vcard.to_param
    assert_response :success
  end

  test "should update vcard" do
    put :update, :id => @vcard.to_param, :vcard => @vcard.attributes
    assert_redirected_to vcard_path(assigns(:vcard))
  end

  test "should destroy vcard" do
    assert_difference('Vcard.count', -1) do
      delete :destroy, :id => @vcard.to_param
    end

    assert_redirected_to vcards_path
  end
end
