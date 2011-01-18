# encoding: utf-8

require 'test_helper'

class SipAccountCodecTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:sip_account_codec).valid?
  end
  
  #TODO tests
end
