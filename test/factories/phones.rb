# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :phone do |f|
  f.sequence(:mac_address) { |n| ('%012d' % n).to_s }
  f.phone_model_id 1
  f.sequence(:ip_address) { |n| "10.10.0.#{n}" }
end
