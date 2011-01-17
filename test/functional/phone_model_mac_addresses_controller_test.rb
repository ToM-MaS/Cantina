require 'test_helper'

class PhoneModelMacAddressesControllerTest < ActionController::TestCase
  setup do
    @phone_model_mac_address =  Factory.create(:phone_model_mac_address)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_model_mac_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_model_mac_address" do
    assert_difference('PhoneModelMacAddress.count') do
      post :create, :phone_model_mac_address => Factory.attributes_for(:phone_model_mac_address)
    end

    assert_redirected_to phone_model_mac_address_path(assigns(:phone_model_mac_address))
  end

  test "should show phone_model_mac_address" do
    get :show, :id => @phone_model_mac_address.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @phone_model_mac_address.to_param
    assert_response :success
  end

  test "should update phone_model_mac_address" do
    put :update, :id => @phone_model_mac_address.to_param, :phone_model_mac_address => @phone_model_mac_address.attributes
    assert_redirected_to phone_model_mac_address_path(assigns(:phone_model_mac_address))
  end

  test "should destroy phone_model_mac_address" do
    assert_difference('PhoneModelMacAddress.count', -1) do
      delete :destroy, :id => @phone_model_mac_address.to_param
    end

    assert_redirected_to phone_model_mac_addresses_path
  end
end
