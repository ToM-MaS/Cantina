class RebootRequest < ActiveRecord::Base
  validates_presence_of :phone_id
  validates_numericality_of :phone_id, :only_integer => true, :greater_than_or_equal_to => 0

  belongs_to :phone

  default_value_for :start, Time.now
  default_value_for :successful, false
  
  # private  
  #   if (phone.phone_model.manufacturer.ieee_name == "SNOM Technology AG")
  #     success = reboot_phone_by_http(:ip_address => phone.ip_address, :path => 'confirm.htm?REBOOT=yes', :user => phone.http_user, :password => phone.http_password)
  #   elsif (phone.phone_model.manufacturer.ieee_name == "DeTeWe-Deutsche Telephonwerke")
  #     success = reboot_phone_by_http(:ip_address => phone.ip_address, :path => 'logout.html', :user => phone.http_user, :password => phone.http_password)
  #     success = reboot_phone_by_http(:ip_address => phone.ip_address, :path => 'logout.html', :user => phone.http_user, :password => phone.http_password)
  #     success = reboot_phone_by_http(:ip_address => phone.ip_address, :path => 'reset.html', :post => {"resetOption" => "0"},:user => phone.http_user, :password => phone.http_password)
  #   end
end
