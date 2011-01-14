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
  validates_presence_of :name
  
  has_many :sip_account_codecs, :dependent => :destroy
  has_many :sip_accounts, :through => :sip_account_codecs
  
  #TODO: Validations
end
