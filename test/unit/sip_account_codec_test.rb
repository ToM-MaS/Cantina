require 'test_helper'

class SipAccountCodecTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:sip_account_codec).valid?
  end
end
