# encoding: utf-8

require 'test_helper'

class SipAccountTest < ActiveSupport::TestCase
  
  should "be valid" do
    assert Factory.build(:sip_account).valid?
  end

  # check validation of different DTMF modes
  #
  ['rfc2833', 'inband', 'info'].each do |dtmf_mode|
    should "be ok to set the dtmf_mode to #{dtmf_mode}" do
      assert Factory.build(:sip_account, :dtmf_mode => dtmf_mode).valid?
    end
  end

  # check validation of wrong DTMF modes
  #
  ['RFC2833', 'outband', 'what_ever', nil].each do |dtmf_mode|
    should "not be ok to set the dtmf_mode to #{dtmf_mode}" do
      assert !Factory.build(:sip_account, :dtmf_mode => dtmf_mode).valid?
    end
  end
  
  # Let test that it is not possible to exceed the maximum number of sip_accounts
  # for a given phone
  #
  should "not be possible to have more sip_accounts as set in the phone_model" do
    max = 5
    phone_model = Factory.create(:phone_model, :max_number_of_sip_accounts => max)
    phone = Factory.create(:phone, :phone_model_id => phone_model.id)
    (1..max).each do
      Factory.create(:sip_account, :phone_id => phone.id)
    end
    assert !Factory.build(:sip_account, :phone_id => phone.id).valid?
  end
  
  # No sip_account without an existing phone
  #
  should "not be possible to create a sip_account without a valid phone" do
    phone = Factory.create(:phone)
    phone.destroy
    assert !Factory.build(:sip_account, :phone_id => phone.id).valid?
  end
  
  # No sip_account with nil as a phone_id
  #
  should "not be possible to set phone_id to nil" do
    assert !Factory.build(:sip_account, :phone_id => nil).valid?
  end
  
  # The position field acts_as_list
  #
  should "be save to add an other sip_account and being sure that the position number is correct" do
    phone_model = Factory.create(:phone_model, :max_number_of_sip_accounts => 3)
    phone = Factory.create(:phone, :phone_model_id => phone_model.id)
    sip_account_1 = Factory.create(:sip_account, :phone_id => phone.id)
    sip_account_2 = Factory.create(:sip_account, :phone_id => phone.id)
    sip_account_3 = Factory.create(:sip_account, :phone_id => phone.id)
    assert sip_account_1.position == 1 and sip_account_2.position == 2 and sip_account_3.position == 3
  end
  
  # Some tests for valid registrar
  #
  [
    '10.0.0.0',
    'www.amooma.de',
    '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
    '2001:0db8:0000:08d3:0000:8a2e:0070:7344',
    '2001:db8:0:8d3:0:8a2e:70:7344',
    '2001:db8:0:0:0:0:1428:57ab',
    '2001:db8::1428:57ab',
    '2001:db8:0:0:8d3:0:0:0',
    '2001:db8:0:0:8d3::',
    '2001:db8::8d3:0:0:0',
    '2001:0db8:1234::',
    '::',  # should this be valid? (valid IPv6 address, but this is the "unspecified" address)
    '::1', # loopback
    'fe80::',  # link-local unicast
    'fec0::',  # site-local unicast
    'fc00::',  # unique local unicast
    'fd9e:21a7:a92c:2323::1',  # unique local unicast
    'ff00::',  # multicast
    '192.0.2.128',
    '::ffff:192.0.2.128',
    '::ffff:c000:280',
    'example.com123',
    'abc',
    'abc.',
  ].each { |valid_registrar|
    should "be possible to set registrar to \"#{valid_registrar}\"" do
      assert Factory.build(:sip_account, :registrar => valid_registrar).valid?
    end
  }
  
  # Some tests for invalid registrar
  #
  [
    '10.0.x.0',
    'www.amooma.01',
    '2001:0xb8:85a3:0000:0000:8a2e:0370:7334',
    '2001:db8::8d3::',
    '2001:0000:85a3:0000:0000:8a2e:0370:73340',
    '::ffff:192.0.2.128.123',
    'example.123com',
    '123',
    '.',
    ' abc',
    'abc ',
    '[',
    'abc.[',
    'a c',
    'a#c',
    '_',
    '_c',
    'a_c',
  ].each { |invalid_registrar|
    should "not be possible to set registrar to \"#{invalid_registrar}\"" do
      assert !Factory.build(:sip_account, :registrar => invalid_registrar).valid?
    end
  }
  
  # valid realm
  #
  [
    'amooma.de',
    'my-realm',
    'abc',
    '123',
    '123\\"123',
  ].each { |valid_realm|
    should "be possible to set realm to \"#{valid_realm}\"" do
      assert Factory.build( :sip_account, :realm => valid_realm ).valid?
    end
  }
  
  # invalid realm
  #
  [
    '123"123',
  ].each { |invalid_realm|
    should "not be possible to set realm to \"#{invalid_realm}\"" do
      assert ! Factory.build( :sip_account, :realm => invalid_realm ).valid?
    end
  }
  
  # valid display_name
  #
  [
    'my-display-name',
    'Philipp Kempgen',
    '',
    "Joe\\'s Pizza",
    "Joe's Pizza",
    'Elvis \\"The King\\" Presley',
    'äöüßé',
    ' !#$%&\'()*+,-./0123:;<=>?@AZ[]^_`az{|}~',
    'まつもと ゆきひろ (a.k.a. Matz)',
    "-\\\x08-",  # escaped \x08 (backspace) char
    "-\\\x18-",  # escaped \x18 (escape) char
    "-\\\x7F-",  # escaped \x7F (delete) char
    "-\\\x09-",  # escaped \x09 (tab) char
    "-\\\x00-",  # escaped \x00 (nul) char
  ].each { |valid_display_name|
    should "be possible to set display_name to \"#{valid_display_name}\"" do
      assert Factory.build( :sip_account, :display_name => valid_display_name ).valid?
    end
  }
  
  # invalid display_name
  #
  [
    "-\x08-",    # unescaped \x08 (backspace) char
    "-\x18-",    # unescaped \x18 (escape) char
    '-"-',
    '\\',
    "-\x7F-",    # unescaped \x7F (delete) char
    "-\\\x0D-",  # escaped \x0D (carriage return) char
    "-\x00-",    # unescaped \x00 (nul) char
  ].each { |invalid_display_name|
    should "not be possible to set display_name to \"#{invalid_display_name}\"" do
      assert ! Factory.build( :sip_account, :display_name => invalid_display_name ).valid?
    end
  }

end
