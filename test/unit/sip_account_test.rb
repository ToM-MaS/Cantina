require 'test_helper'

class SipAccountTest < ActiveSupport::TestCase
  should "be valid" do
    assert SipAccount.new.valid?
  end
end
