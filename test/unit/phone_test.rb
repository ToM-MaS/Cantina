require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:phone).valid?
  end
end
