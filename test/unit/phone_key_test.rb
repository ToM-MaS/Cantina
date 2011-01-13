require 'test_helper'

class PhoneKeyTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:phone_key).valid?
  end
end
