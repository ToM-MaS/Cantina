require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:language).valid?
  end
end
