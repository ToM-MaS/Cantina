require 'test_helper'

class SipAccountTest < ActiveSupport::TestCase
  should "be valid" do
    phone = Factory.create(:phone)
    assert Factory.build(:sip_account, :phone_id => phone.id).valid?
  end
end
