require 'test_helper'

class PhoneKeyFunctionDefinitionsControllerTest < ActionController::TestCase
  setup do
    @phone_key_function_definition = Factory.create(:phone_key_function_definition)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_key_function_definitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_key_function_definition" do
    assert_difference('PhoneKeyFunctionDefinition.count') do
      post :create, :phone_key_function_definition => @phone_key_function_definition.attributes
    end

    assert_redirected_to phone_key_function_definition_path(assigns(:phone_key_function_definition))
  end

  test "should show phone_key_function_definition" do
    get :show, :id => @phone_key_function_definition.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @phone_key_function_definition.to_param
    assert_response :success
  end

  test "should update phone_key_function_definition" do
    put :update, :id => @phone_key_function_definition.to_param, :phone_key_function_definition => @phone_key_function_definition.attributes
    assert_redirected_to phone_key_function_definition_path(assigns(:phone_key_function_definition))
  end

  test "should destroy phone_key_function_definition" do
    assert_difference('PhoneKeyFunctionDefinition.count', -1) do
      delete :destroy, :id => @phone_key_function_definition.to_param
    end

    assert_redirected_to phone_key_function_definitions_path
  end
end
