require 'test_helper'

class SipAccountTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:sip_account).valid?
  end
end
