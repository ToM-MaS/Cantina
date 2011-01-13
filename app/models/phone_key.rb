class PhoneKey < ActiveRecord::Base
  belongs_to :phone
  belongs_to :phone_model_key
  belongs_to :phone_key_function_definition
  
  validates_presence_of :value
end
