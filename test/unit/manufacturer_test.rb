require 'test_helper'

class ManufacturerTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:manufacturer).valid?
  end
end
