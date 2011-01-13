class SipAccount < ActiveRecord::Base
  has_many :sip_account_codecs, :dependent => :destroy
  has_many :codecs, :through => :sip_account_codecs
  
  belongs_to :phone, :validate => true
  acts_as_list :scope => :phone
  
end
