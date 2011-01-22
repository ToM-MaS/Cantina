# == Schema Information
# Schema version: 20110121121114
#
# Table name: phone_key_to_function_mappings
#
#  id                               :integer         not null, primary key
#  phone_model_key_id               :integer
#  phone_key_function_definition_id :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#

class PhoneKeyToFunctionMapping < ActiveRecord::Base
  belongs_to :phone_key_function_definition
  belongs_to :phone_mode_key
  
  # TODO Testing and validation
end
