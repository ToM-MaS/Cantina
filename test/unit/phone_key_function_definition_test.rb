require 'test_helper'

class PhoneKeyFunctionDefinitionTest < ActiveSupport::TestCase
  should "be valid" do
    assert PhoneKeyFunctionDefinition.new.valid?
  end
end
