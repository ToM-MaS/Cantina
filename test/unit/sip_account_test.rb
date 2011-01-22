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
    phone_model = Factory.create(:phone_model, :max_number_of_sip_accounts => 3)
    
    phone = Factory.create(:phone, :phone_model_id => phone_model.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    
    assert phone.sip_accounts.count == 3
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
    should "be possible to set registrar to #{valid_registrar.inspect}" do
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
    should "not be possible to set registrar to #{invalid_registrar.inspect}" do
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
    should "be possible to set realm to #{valid_realm.inspect}" do
      assert Factory.build( :sip_account, :realm => valid_realm ).valid?
    end
  }
  
  # invalid realm
  #
  [
    '123"123',
  ].each { |invalid_realm|
    should "not be possible to set realm to #{invalid_realm.inspect}" do
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
    should "be possible to set display_name to #{valid_display_name.inspect}" do
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
    should "not be possible to set display_name to #{invalid_display_name.inspect}" do
      assert ! Factory.build( :sip_account, :display_name => invalid_display_name ).valid?
    end
  }
  
  
  # valid registrar_port, outbound_proxy_port, sip_proxy_port
  #
  [
    1,
    65535,
    '1',
    '',
    nil,
  ].each { |port|
    should "be possible to set registrar_port to #{port.inspect}" do
      assert Factory.build( :sip_account, :registrar_port => port ).valid?
    end
    should "be possible to set outbound_proxy_port to #{port.inspect}" do
      assert Factory.build( :sip_account, :outbound_proxy_port => port ).valid?
    end
    should "be possible to set sip_proxy_port to #{port.inspect}" do
      assert Factory.build( :sip_account, :sip_proxy_port => port ).valid?
    end
  }
  
  # invalid registrar_port, outbound_proxy_port, sip_proxy_port
  #
  [
    0,
    '0',
    65536,
    ' 1',
    3.14,
    '3.14',
    'foo',
  ].each { |port|
    should "not be possible to set registrar_port to #{port.inspect}" do
      assert ! Factory.build( :sip_account, :registrar_port => port ).valid?
    end
    should "not be possible to set outbound_proxy_port to #{port.inspect}" do
      assert ! Factory.build( :sip_account, :outbound_proxy_port => port ).valid?
    end
    should "not be possible to set sip_proxy_port to #{port.inspect}" do
      assert ! Factory.build( :sip_account, :sip_proxy_port => port ).valid?
    end
  }
  
  
  # valid registration_expiry_time
  #
  [
    1,
    65535,
    2147483647,
    4294967295,  # (2**32)-1, see https://tools.ietf.org/html/rfc3261#section-10.2
    '1',
    '',
    nil,
  ].each { |registration_expiry_time|
    should "be possible to set registration_expiry_time to #{registration_expiry_time.inspect}" do
      assert Factory.build( :sip_account, :registration_expiry_time => registration_expiry_time ).valid?
    end
  }
  
  # invalid registration_expiry_time
  #
  [
    0,
    '0',
    ' 1',
    3.14,
    '3.14',
    'foo',
    4294967296,
  ].each { |registration_expiry_time|
    should "not be possible to set registration_expiry_time to #{registration_expiry_time.inspect}" do
      assert ! Factory.build( :sip_account, :registration_expiry_time => registration_expiry_time ).valid?
    end
  }
  
  
  # valid password, remote_password
  #
  [
    nil,
    '',
    'ABCabc012',
    '-_.!~*\'()',
    '&=+$,',
    '%00',
    '%20',
    '%FF',
  ].each { |password|
    should "be possible to set password to #{password.inspect}" do
      assert Factory.build( :sip_account, :password => password ).valid?
    end
    should "be possible to set remote_password to #{password.inspect}" do
      assert Factory.build( :sip_account, :remote_password => password ).valid?
    end
  }
  
  # invalid password, remote_password
  #
  [
    '%2',
    '%XX',
    '%ff',
    '%Ff',
    '%',
    '%%%',
    '"',
    ':',
    '#',
    '\\',
    'x' * 256,
  ].each { |password|
    should "not be possible to set password to #{password.inspect}" do
      assert ! Factory.build( :sip_account, :password => password ).valid?
    end
    should "not be possible to set remote_password to #{password.inspect}" do
      assert ! Factory.build( :sip_account, :remote_password => password ).valid?
    end
  }
  
  
  # valid auth_user
  #
  [
    nil,
    '',
    'elvis',
    'Elvis123',
    '-_.!~*\'()',
    '%FF',
    '&=+$,;?/',
  ].each { |username|
    should "be possible to set auth_user to #{username.inspect}" do
      assert Factory.build( :sip_account, :auth_user => username ).valid?
    end
  }
  
  # invalid auth_user
  #
  [
    '%A',
    '%XX',
    '%Ff',
    "\x00",
    '\\',
    '"',
    'x' * 256,
  ].each { |username|
    should "not be possible to set auth_user to #{username.inspect}" do
      assert ! Factory.build( :sip_account, :auth_user => username ).valid?
    end
  }
  
  
  # valid user
  #
  [
    'elvis',
    '-_.!~*\'()',
  ].each { |username|
    should "be possible to set user to #{username.inspect}" do
      assert Factory.build( :sip_account, :user => username ).valid?
    end
  }
  
  # invalid user
  #
  [
    nil,
    '',
    '#',
    ':',
    '^',
    '<',
    '[',
    '{',
    'x' * 256,
  ].each { |username|
    should "not be possible to set user to #{username.inspect}" do
      assert ! Factory.build( :sip_account, :user => username ).valid?
    end
  }
  
  
end
