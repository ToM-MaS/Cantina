require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:phone).valid?
  end

  # Test invalid mac addresses
  #
  [
    nil,
    '007',
    'AAFF0011',
    '1122334455GG',
    '11:22:33:aa:bb:cc:',
    '112233aabbcc11',
    'not_a_valid_MAC_address'
  ].each do |invalid_mac_address|
    should "not allow #{invalid_mac_address} as an mac_address" do
      assert !Factory.build(:phone, :mac_address => invalid_mac_address).valid?
    end
  end

  # Test valid mac addresses
  #
  [
    '11:22:33:aa:bb:cc',
    '11:22:33:AA:BB:cc',
    '112233AABBcc',
    '00-11-22-33-44-55'
  ].each do |valid_mac_address|
    should "allow #{valid_mac_address} as an mac_address" do
      assert Factory.build(:phone, :mac_address => valid_mac_address).valid?
    end
  end

  # mac_address has to be unique
  #
  should "not allow two phone entries with the same mac_address" do
    phone = Factory.create(:phone)
    assert !Factory.build(:phone, :mac_address => phone.mac_address).valid?
  end

  # Test invalid ip addresses
  [
    '1.2.3.',
    '1.2.3.256',
    '010.000.00.005',
    '1.1.1.',
    'asfd',
    '112233AABBcc'
  ].each do |invalid_ip_address|
    should "not allow #{invalid_ip_address} as an ip_address" do
      assert !Factory.build(:phone, :ip_address => invalid_ip_address).valid?
    end
  end

  # Test valid ip addresses
  [
    '1.2.3.4',
    '255.255.255.255',
    '123.123.123.123',
    '1.10.100.250',
    '',
    nil,
  ].each do |valid_ip_address|
    should "allow #{valid_ip_address} as an ip_address" do
      assert Factory.build(:phone, :ip_address => valid_ip_address).valid?
    end
  end

  # ip_address has to be unique
  #
  should "not be valid" do
    phone = Factory.create(:phone)
    assert !Factory.build(:phone, :ip_address => phone.ip_address).valid?
  end
  
  # Test invalid phone model
  [
    -1,
  ].each do |phone_model_id|
    should "not allow #{phone_model_id.inspect} as a phone_model_id" do
      assert ! Factory.build( :phone, :phone_model_id => phone_model_id ).valid?
    end
  end
  
  
  # Test if Phone has a log_provisioning() instance method.
  should "have a \"log_provisioning\" instance method" do
    assert Phone.new().respond_to?( :log_provisioning )
  end
  
  
  # check a full setup
  #
  should "have all bells and whistles" do
    # Create a phone_model with some codecs and some keys
    #
    phone_model = Factory.create(:phone_model, :max_number_of_sip_accounts => 3)
    phone_model.codecs << Factory.create(:codec)
    phone_model.codecs << Factory.create(:codec)
    phone_model.codecs << Factory.create(:codec)
    phone_model.codecs << Factory.create(:codec)
    phone_model.codecs << Factory.create(:codec)

    PhoneKeyFunctionDefinition.create([
      { :name => 'BLF'              , :type_of_class => 'string'  , :regex_validation => nil },
      { :name => 'Speed dial'       , :type_of_class => 'string'  , :regex_validation => nil },
      { :name => 'ActionURL'        , :type_of_class => 'url'     , :regex_validation => nil },
      { :name => 'Line'             , :type_of_class => 'integer' , :regex_validation => nil }
    ])  
    
    (1..10).each do |key_number|
      phone_model_key = phone_model.phone_model_keys.create(:name => "F#{key_number}")
      phone_model_key.phone_key_function_definitions << PhoneKeyFunctionDefinition.all
    end
    
    phone = Factory.create(:phone, :phone_model_id => phone_model.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    
    (0 .. 2).each do |i|
      (0 .. i).each do |codec_i|
        phone.sip_accounts[i].codecs << phone_model.codecs[codec_i]
      end
    end

    first_sip_account = phone.sip_accounts.first
    
    # Lets create a BLF 42 on the first key at the first sip_account
    f1 = first_sip_account.phone_keys.create
    f1.phone_model_key_id = phone_model.phone_model_keys.first.id
    f1.phone_key_function_definition_id = phone_model.phone_model_keys.first.phone_key_function_definitions.first.id
    f1.value = "42"
    f1.save

    assert phone_model.codecs.size == 5    
    assert phone.sip_accounts.size == 3
    assert phone.sip_accounts.first.codecs.count == 1
    assert phone.sip_accounts.last.codecs.count == 3
    assert f1.valid?
    assert first_sip_account.valid?
  end
  
end
