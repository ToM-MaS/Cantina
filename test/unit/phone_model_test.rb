require 'test_helper'

class PhoneModelTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:phone_model).valid?
  end
end
