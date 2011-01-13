# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :vcard do |f|
  f.name "MyString"
  f.content "MyText"
  f.position 1
  f.vcardable_type "MyString"
  f.vcardable_id 1
end
