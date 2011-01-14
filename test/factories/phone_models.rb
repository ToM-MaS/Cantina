# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :phone_model do |f|
  f.sequence(:name) { |n| "Manufacturer #{n}" }
  f.association :manufacturer
end
