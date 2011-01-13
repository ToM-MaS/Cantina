require 'test_helper'

class PhoneModelTest < ActiveSupport::TestCase
  should "be valid" do
    assert PhoneModel.new.valid?
  end
end
