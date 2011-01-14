# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :sip_account do |f|
  #f.name "Example SIP-Account"
  f.phone_id 1
  # f.auth_user "MyString"
  f.user "test_sip_user"
  # f.password "MyString"
  # f.registrar "10.0.0.1"
  # f.registrar_port 1
  # f.outbound_proxy "MyString"
  # f.outbound_proxy_port 1
  # f.sip_proxy "MyString"
  # f.sip_proxy_port 1
  # f.realm "MyString"
  # f.screen_name "MyString"
  # f.display_name "MyString"
  # f.registration_expiry_time 1
  # f.dtmf_mode "MyString"
  # f.remote_password "MyString"
  # f.position 1
  
  f.association :phone
end
