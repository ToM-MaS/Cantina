# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :sip_account do |f|
  f.sequence(:user) { |n| "test_sip_user_#{n}" }
  f.association :phone
end
