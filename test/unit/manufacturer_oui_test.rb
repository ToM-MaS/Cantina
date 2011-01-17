require 'test_helper'

class ManufacturerOuiTest < ActiveSupport::TestCase
  should "be valid" do
    assert ManufacturerOui.new.valid?
  end
end
