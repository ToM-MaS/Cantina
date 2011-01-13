# == Schema Information
# Schema version: 20110113094740
#
# Table name: phone_key_function_definitions
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  type_of_class    :string(255)
#  regex_validation :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class PhoneKeyFunctionDefinition < ActiveRecord::Base
  belongs_to :phone_model_key
  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  
  has_many :phone_keys, :dependent => :destroy
end
