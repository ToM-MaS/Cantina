# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :phone do |f|
  f.mac_address "MyString"
  f.phone_model_id 1
  f.ip_address "MyString"
end
