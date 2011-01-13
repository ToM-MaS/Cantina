require 'test_helper'

class CodecTest < ActiveSupport::TestCase
  should "be valid" do
     assert Factory.build(:codec).valid?
  end
end
