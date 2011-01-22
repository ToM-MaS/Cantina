require 'test_helper'

class PhoneKeyTest < ActiveSupport::TestCase
  # should "not be valid" do
  #   assert !Factory.build(:phone_key).valid?
  # end
  
  should "be a defined key of the phone_model" do
    phone_model = Array.new

    PhoneKeyFunctionDefinition.create([
      { :name => 'BLF'              , :type_of_class => 'string'  , :regex_validation => nil },
      { :name => 'Speed dial'       , :type_of_class => 'string'  , :regex_validation => nil },
      { :name => 'ActionURL'        , :type_of_class => 'url'     , :regex_validation => nil },
      { :name => 'Line'             , :type_of_class => 'integer' , :regex_validation => nil }
    ])  
    
    # We create two phone_models. Each with a set of 10 phone_model_keys
    #
    (1..2).each do |i|
      phone_model[i] = Factory.create(:phone_model)

      (1..10).each do |key_number|
        phone_model_key = phone_model[i].phone_model_keys.create(:name => "F#{key_number}")
        phone_model_key.phone_key_function_definitions << PhoneKeyFunctionDefinition.all
      end
    
      phone = Factory.create(:phone, :phone_model_id => phone_model[i].id)
      Factory.create(:sip_account, :phone_id => phone.id)
    end
    
    first_sip_account = phone_model[1].phones.first.sip_accounts.first

    # Let's try to create a phone key from the wrong phone_model  
    #  
    unvalid_f1 = first_sip_account.phone_keys.build
    unvalid_f1.phone_model_key_id = phone_model[2].phone_model_keys.first.id
    unvalid_f1.phone_key_function_definition_id = phone_model[2].phone_model_keys.first.phone_key_function_definitions.first.id
    unvalid_f1.value = "42"
    
    # Let's try to create a phone key from the right phone_model  
    #  
    valid_f1 = first_sip_account.phone_keys.build
    valid_f1.phone_model_key_id = phone_model[1].phone_model_keys.first.id
    valid_f1.phone_key_function_definition_id = phone_model[1].phone_model_keys.first.phone_key_function_definitions.first.id
    valid_f1.value = "42"
    
    assert !unvalid_f1.valid?
    assert valid_f1.valid?
  end
  
  should "be a defined key_function for this phone_key" do
    phone_model = Array.new

    PhoneKeyFunctionDefinition.create([
      { :name => 'BLF'              , :type_of_class => 'string'  , :regex_validation => nil },
      { :name => 'Speed dial'       , :type_of_class => 'string'  , :regex_validation => nil },
      { :name => 'ActionURL'        , :type_of_class => 'url'     , :regex_validation => nil },
      { :name => 'Line'             , :type_of_class => 'integer' , :regex_validation => nil }
    ])  
    
    # We create two phone_models. Each with a set of 10 phone_model_keys
    #
    (1..2).each do |i|
      phone_model[i] = Factory.create(:phone_model)

      (1..10).each do |key_number|
        phone_model_key = phone_model[i].phone_model_keys.create(:name => "F#{key_number}")
        phone_model_key.phone_key_function_definitions << PhoneKeyFunctionDefinition.all
      end
    
      phone = Factory.create(:phone, :phone_model_id => phone_model[i].id)
      Factory.create(:sip_account, :phone_id => phone.id)
    end
    
    # destroy the BLF function for the first key of the first phone_model
    phone_model[1].phone_model_keys.first.phone_key_to_function_mappings.first.destroy
    
    first_sip_account = phone_model[1].phones.first.sip_accounts.first

    # Let's try to create a phone key from the right phone_model  
    #  
    valid_f1 = first_sip_account.phone_keys.build
    valid_f1.phone_model_key_id = phone_model[1].phone_model_keys.first.id
    valid_f1.phone_key_function_definition_id = phone_model[2].phone_model_keys.first.phone_key_function_definitions.first.id
    valid_f1.value = "42"
    
    assert !valid_f1.valid?
  end
  
  
end
