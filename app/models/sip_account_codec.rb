# == Schema Information
# Schema version: 20110113094740
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
  belongs_to :available_codec
end
