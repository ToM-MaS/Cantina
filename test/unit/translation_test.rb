require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:translation).valid?
  end
end
