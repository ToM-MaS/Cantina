require 'test_helper'

class ManufacturerTest < ActiveSupport::TestCase
  should "be valid" do
    assert Manufacturer.new.valid?
  end
end
