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
    '00-11-22-33-44-55',
    'not_a_valid_MAC_Address'
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
     '112233AABBcc'
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
     '1.10.100.250'
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

end
