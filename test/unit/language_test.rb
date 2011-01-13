require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  should "be valid" do
    assert Language.new.valid?
  end
end
