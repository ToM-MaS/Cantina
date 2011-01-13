require 'test_helper'

class VcardTest < ActiveSupport::TestCase
  should "be valid" do
    assert Vcard.new.valid?
  end
end
