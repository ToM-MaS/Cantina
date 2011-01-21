# encoding: utf-8

require 'test_helper'

class SipAccountCodecTest < ActiveSupport::TestCase
  should "not be valid" do
    assert !Factory.build(:sip_account_codec).valid?
  end

  should "belong to a phone_model which has this codec" do
    phone_model = Factory.create(:phone_model)
    phone_model.codecs << Factory.create(:codec)
    
    phone = Factory.create(:phone, :phone_model_id => phone_model.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    
    assert phone.sip_accounts.first.sip_account_codecs.build(:codec_id => phone_model.codecs.first.id).valid?
  end
 
  should "not belong to a phone_model which doesn't have this codec" do
    phone_model = Factory.create(:phone_model)
    phone_model.codecs << Factory.create(:codec)
    
    random_codec = Factory.create(:codec)
    
    phone = Factory.create(:phone, :phone_model_id => phone_model.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    
    assert !phone.sip_accounts.first.sip_account_codecs.build(:codec_id => random_codec.id).valid?    
  end
  
  should "be unique for the given sip_account" do
    phone_model = Factory.create(:phone_model)
    phone_model.codecs << Factory.create(:codec)
    
    phone = Factory.create(:phone, :phone_model_id => phone_model.id)
    Factory.create(:sip_account, :phone_id => phone.id)
    
    phone.sip_accounts.first.sip_account_codecs.create(:codec_id => phone_model.codecs.first.id)
    
    assert !phone.sip_accounts.first.sip_account_codecs.build(:codec_id => phone_model.codecs.first.id).valid?
  end
end
