# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :phone_key do |f|
  f.phone_id 1
  f.phone_model_key_id 1
  f.phone_key_function_definition_id 1
  f.value "MyString"
end
