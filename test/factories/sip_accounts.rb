# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :sip_account do |f|
  f.sequence(:user) { |n| "test sip user #{n}" }
  f.association :phone
end
