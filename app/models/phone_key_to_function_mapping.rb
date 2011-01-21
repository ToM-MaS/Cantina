class PhoneKeyToFunctionMapping < ActiveRecord::Base
  belongs_to :phone_key_function_definition
  belongs_to :phone_mode_key
  
  # TODO Testing and validation
end
