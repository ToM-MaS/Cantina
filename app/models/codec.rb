# == Schema Information
# Schema version: 20110113200244
#
# Table name: codecs
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Codec < ActiveRecord::Base
  has_many :sip_account_codecs, :dependent => :destroy
  has_many :sip_accounts, :through => :sip_account_codecs
  
  #TODO: Validations
  
  validates_presence_of :name
  #validates_format_of   :name, :with => /^[a-zA-Z0-9.\-_]{1,40}$/, :allow_nil => false, :allow_blank => false
end
