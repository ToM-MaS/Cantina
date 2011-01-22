# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :phone_key do |f|
  f.value "MyString"
  
  f.association :sip_account
	f.association :phone_model_key
	f.association :phone_key_function_definition

  # f.sip_account_id 1
  # f.phone_model_key_id 1
  # f.phone_key_function_definition_id 1
  
  # TODO Maybe it is possible to create a valid Factory for phone_key
end
