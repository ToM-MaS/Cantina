require 'test_helper'

class OuiTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:oui).valid?
  end
  
  # TODO tests for oui
end
