require 'test_helper'

class PhoneKeysControllerTest < ActionController::TestCase
  setup do
    @phone_key = Factory.create(:phone_key)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_keys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_key" do
    assert_difference('PhoneKey.count') do
      post :create, :phone_key => @phone_key.attributes
    end

    assert_redirected_to phone_key_path(assigns(:phone_key))
  end

  test "should show phone_key" do
    get :show, :id => @phone_key.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @phone_key.to_param
    assert_response :success
  end

  test "should update phone_key" do
    put :update, :id => @phone_key.to_param, :phone_key => @phone_key.attributes
    assert_redirected_to phone_key_path(assigns(:phone_key))
  end

  test "should destroy phone_key" do
    assert_difference('PhoneKey.count', -1) do
      delete :destroy, :id => @phone_key.to_param
    end

    assert_redirected_to phone_keys_path
  end
end
