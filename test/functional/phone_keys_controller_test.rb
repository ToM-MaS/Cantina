require 'test_helper'

class PhoneKeysControllerTest < ActionController::TestCase
  setup do
    phone_model = Array.new

    PhoneKeyFunctionDefinition.create([
      { :name => 'BLF'              , :type_of_class => 'string'  , :regex_validation => nil },
      { :name => 'Speed dial'       , :type_of_class => 'string'  , :regex_validation => nil },
      { :name => 'ActionURL'        , :type_of_class => 'url'     , :regex_validation => nil },
      { :name => 'Line'             , :type_of_class => 'integer' , :regex_validation => nil }
    ])  
    
    phone_model = Factory.create(:phone_model, :number_of_keys => 10, :max_number_of_sip_accounts => 10)

    (1..10).each do |key_number|
      phone_model_key = phone_model.phone_model_keys.create(:name => "F#{key_number}")
      phone_model_key.phone_key_function_definitions << PhoneKeyFunctionDefinition.all
    end
  
    phone = Factory.create(:phone, :phone_model_id => phone_model.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    
    @first_sip_account = phone_model.phones.first.sip_accounts.first

    @phone_key = @first_sip_account.phone_keys.build
    @phone_key.phone_model_key_id = phone_model.phone_model_keys.first.id
    @phone_key.phone_key_function_definition_id = phone_model.phone_model_keys.first.phone_key_function_definitions.first.id
    @phone_key.value = "42"
    @phone_key.save
  end

  test "should get index" do
    get :index, :sip_account_id => @first_sip_account.id
    assert_response :success
    assert_not_nil assigns(:phone_keys)
  end

  test "should get new" do
    get :new, :sip_account_id => @first_sip_account.id
    assert_response :success
  end

  test "should create phone_key" do
    assert_difference('PhoneKey.count') do
      post :create, :sip_account_id => @first_sip_account.id, :phone_key => Factory.attributes_for(:phone_key,  
                                                         :sip_account_id => @phone_key.sip_account_id, 
                                                         :phone_model_key_id => @first_sip_account.phone.phone_model.phone_model_keys.last.id,
                                                         :phone_key_function_definition_id => @first_sip_account.phone.phone_model.phone_model_keys.first.phone_key_function_definitions.last.id,
                                                         :value => '42'
                                                         )
    end

    assert_redirected_to sip_account_path(assigns(:phone_key).sip_account)
  end

  test "should show phone_key" do
    get :show, :sip_account_id => @first_sip_account.id, :id => @phone_key.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :sip_account_id => @first_sip_account.id, :id => @phone_key.to_param
    assert_response :success
  end

  test "should update phone_key" do
    put :update, :sip_account_id => @first_sip_account.id, :id => @phone_key.to_param, :phone_key => @phone_key.attributes
    assert_redirected_to sip_account_path(assigns(:phone_key).sip_account)
  end

  test "should destroy phone_key" do
    assert_difference('PhoneKey.count', -1) do
      delete :destroy, :sip_account_id => @first_sip_account.id, :id => @phone_key.to_param
    end

    assert_redirected_to sip_account_path(assigns(:phone_key).sip_account)
  end
end
