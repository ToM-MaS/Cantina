# == Schema Information
# Schema version: 20110117122740
#
# Table name: codecs
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Codec < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of   :name, :with => /^[a-zA-Z0-9.\-_]{1,40}$/, :allow_nil => false, :allow_blank => false
  
  has_many :sip_account_codecs, :dependent => :destroy
  has_many :sip_accounts, :through => :sip_account_codecs
  
end
