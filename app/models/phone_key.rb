# == Schema Information
# Schema version: 20110113200244
#
# Table name: phone_keys
#
#  id                               :integer         not null, primary key
#  phone_model_key_id               :integer
#  phone_key_function_definition_id :integer
#  value                            :string(255)
#  created_at                       :datetime
#  updated_at                       :datetime
#  sip_account_id                   :integer
#

class PhoneKey < ActiveRecord::Base
  belongs_to :sip_account
  belongs_to :phone_model_key
  belongs_to :phone_key_function_definition
  
  validates_presence_of :value
end
