require 'test_helper'

class ManufacturerTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:manufacturer).valid?
  end
  
  # A manufacturer name must be unique
  should "not be valid with not unique name" do
    manufacturer = Factory.create(:manufacturer)
    assert !Factory.build(:manufacturer, :name => manufacturer.name).valid?
  end
  
end
