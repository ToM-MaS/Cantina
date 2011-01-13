# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :translation do |f|
  f.value "MyString"
  f.language_id 1
  f.translatable_type "MyString"
  f.translatable_id 1
end
