require 'test_helper'

class VcardTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:vcard).valid?
  end
end
