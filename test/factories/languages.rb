# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :language do |f|
  f.sequence(:name) { |n| "Language #{n}" }
end
