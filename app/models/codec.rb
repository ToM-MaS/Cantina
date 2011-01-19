# == Schema Information
# Schema version: 20110119105502
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
  
  has_many :phone_model_codecs, :dependent => :destroy
  has_many :phone_models, :through => :phone_model_codecs
end
