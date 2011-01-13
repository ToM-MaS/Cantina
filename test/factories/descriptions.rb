# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :description do |f|
  f.name "MyString"
  f.descriptionable_type "MyString"
  f.descriptionable_id 1
end
