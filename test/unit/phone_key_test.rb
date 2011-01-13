require 'test_helper'

class PhoneKeyTest < ActiveSupport::TestCase
  should "not be valid" do
    assert !PhoneKey.new.valid?
  end
end
