# == Schema Information
# Schema version: 20110117122740
#
# Table name: sip_account_codecs
#
#  id             :integer         not null, primary key
#  codec_id       :integer
#  sip_account_id :integer
#  position       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class SipAccountCodec < ActiveRecord::Base
  validates_presence_of :codec_id
  validates_presence_of :sip_account_id
  validates_numericality_of :codec_id, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :sip_account_id, :only_integer => true, :greater_than_or_equal_to => 0
  
  belongs_to :sip_account
  belongs_to :codec
end
