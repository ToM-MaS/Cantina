require 'test_helper'

class DescriptionTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:description).valid?
  end
end
