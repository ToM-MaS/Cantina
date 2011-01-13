require 'test_helper'

class PhoneModelKeyTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:phone_model_key).valid?
  end
end
