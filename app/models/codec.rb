class Codec < ActiveRecord::Base
  validates_presence_of :name
  
  has_many :sip_account_codecs, :dependent => :destroy
  has_many :sip_accounts, :through => :sip_account_codecs
end
