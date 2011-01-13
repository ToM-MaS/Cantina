require 'test_helper'

class PhoneKeyFunctionDefinitionTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:phone_key_function_definition).valid?
  end
end
