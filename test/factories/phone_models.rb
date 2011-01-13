# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :phone_model do |f|
  f.name "MyString"
  f.manufacturer_id 1
  f.max_number_of_sip_accounts 1
  f.number_of_keys 1
  f.max_number_of_phone_book_entries 1
end
