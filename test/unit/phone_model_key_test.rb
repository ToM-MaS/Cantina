require 'test_helper'

class PhoneModelKeyTest < ActiveSupport::TestCase
  should "be valid" do
    assert PhoneModelKey.new.valid?
  end
end
