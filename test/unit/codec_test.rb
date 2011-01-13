require 'test_helper'

class CodecTest < ActiveSupport::TestCase
  should "not be valid" do
    assert !Codec.new.valid?
  end
end
