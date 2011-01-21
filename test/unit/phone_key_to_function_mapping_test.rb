require 'test_helper'

class PhoneKeyToFunctionMappingTest < ActiveSupport::TestCase
  should "be valid" do
    assert PhoneKeyToFunctionMapping.new.valid?
  end
end
