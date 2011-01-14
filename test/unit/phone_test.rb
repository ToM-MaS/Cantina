require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:phone).valid?
  end
  
  # Test not valid mac addresses
  #
  should "not be valid" do
    assert !Factory.build(:phone, :mac_address => nil).valid?
  end

  should "not be valid" do
    assert !Factory.build(:phone, :mac_address => '007').valid?
  end

  should "not be valid" do
    assert !Factory.build(:phone, :mac_address => 'AAFF0011').valid?
  end

  should "not be valid" do
    assert !Factory.build(:phone, :mac_address => '1122334455GG').valid?
  end
  
  should "not be valid" do
    assert !Factory.build(:phone, :mac_address => '11:22:33:aa:bb:cc:').valid?
  end

  should "not be valid" do
    assert !Factory.build(:phone, :mac_address => '112233aabbcc11').valid?
  end
  
  
  # Test valid mac addresses
  #
  should "be valid" do
    assert Factory.build(:phone, :mac_address => '11:22:33:aa:bb:cc').valid?
  end
  
  should "be valid" do
    assert Factory.build(:phone, :mac_address => '00-11-22-33-44-55').valid?
  end
  
  should "be valid" do
    assert Factory.build(:phone, :mac_address => '11:22:33:AA:BB:cc').valid?
  end

  should "be valid" do
    assert Factory.build(:phone, :mac_address => '112233AABBcc').valid?
  end
  
  # mc address has to be unique
  #
  should "not be valid" do
    phone = Factory.create(:phone)
    assert !Factory.build(:phone, :mac_address => phone.mac_address).valid?
  end


  # Test invalid ip addresses
  should "not be valid" do
    assert Factory.build(:phone, :ip_address => '1.2.3.').valid?
  end

  should "not be valid" do
    assert Factory.build(:phone, :ip_address => '1.2.3.256').valid?
  end
  
  # Test valid ip addresses
  #
  should "be valid" do
    assert Factory.build(:phone, :ip_address => '1.2.3.4').valid?
  end

  should "be valid" do
    assert Factory.build(:phone, :ip_address => '255.255.255.255').valid?
  end

  # ip_address has to be unique
  #
  should "not be valid" do
    phone = Factory.create(:phone)
    assert !Factory.build(:phone, :ip_address => phone.ip_address).valid?
  end
  
end
