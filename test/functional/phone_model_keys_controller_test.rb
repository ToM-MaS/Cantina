require 'test_helper'

class PhoneModelKeysControllerTest < ActionController::TestCase
  setup do
    @phone_model_key = Factory.create(:phone_model_key)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_model_keys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_model_key" do
    assert_difference('PhoneModelKey.count') do
      post :create, :phone_model_key => @phone_model_key.attributes
    end

    assert_redirected_to phone_model_key_path(assigns(:phone_model_key))
  end

  test "should show phone_model_key" do
    get :show, :id => @phone_model_key.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @phone_model_key.to_param
    assert_response :success
  end

  test "should update phone_model_key" do
    put :update, :id => @phone_model_key.to_param, :phone_model_key => @phone_model_key.attributes
    assert_redirected_to phone_model_key_path(assigns(:phone_model_key))
  end

  test "should destroy phone_model_key" do
    assert_difference('PhoneModelKey.count', -1) do
      delete :destroy, :id => @phone_model_key.to_param
    end

    assert_redirected_to phone_model_keys_path
  end
end
