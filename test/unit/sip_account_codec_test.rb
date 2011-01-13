require 'test_helper'

class SipAccountCodecTest < ActiveSupport::TestCase
  should "be valid" do
    assert SipAccountCodec.new.valid?
  end
end
