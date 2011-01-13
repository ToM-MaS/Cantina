require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  should "be valid" do
    assert Translation.new.valid?
  end
end
