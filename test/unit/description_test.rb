require 'test_helper'

class DescriptionTest < ActiveSupport::TestCase
  should "be valid" do
    assert Description.new.valid?
  end
end
