# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :sip_account_codec do |f|
  f.association :sip_account
  f.codec_id 1
  f.sip_account_id 1
end
