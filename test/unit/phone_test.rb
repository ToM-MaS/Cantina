require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  should "be valid" do
    assert Phone.new.valid?
  end
end
