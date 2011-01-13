# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :phone_key_function_definition do |f|
  f.name "MyString"
  f.type_of_class "MyString"
  f.regex_validation "MyString"
end
