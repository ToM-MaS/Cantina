class RebootRequest < ActiveRecord::Base
  validates_presence_of :phone_id
  validates_numericality_of :phone_id, :only_integer => true, :greater_than_or_equal_to => 0
  
  belongs_to :phone
  
  default_value_for :start, Time.now
  default_value_for :successful, false
  
  def self.trigger_reboot(mac_address)
    phone = Phone.find_by_mac_address(mac_address.upcase())
    if (phone)
      return self.reboot_phone(phone)
    else
      return false
    end
  end
  
  private  
  def self.reboot_phone(phone)
    # TODO Different reboot behavior according to phone model
    
    if (phone.class != Phone)
      return false
    end
    
    if (phone.phone_model.manufacturer.ieee_name == "SNOM Technology AG")
      success = reboot_phone_by_http(:ip_address => phone.ip_address, :path => 'confirm.htm?REBOOT=yes', :user => phone.http_user, :password => phone.http_password)
    elsif (phone.phone_model.manufacturer.ieee_name == "DeTeWe-Deutsche Telephonwerke")
      success = reboot_phone_by_http(:ip_address => phone.ip_address, :path => 'logout.html', :user => phone.http_user, :password => phone.http_password)
      success = reboot_phone_by_http(:ip_address => phone.ip_address, :path => 'logout.html', :user => phone.http_user, :password => phone.http_password)
      success = reboot_phone_by_http(:ip_address => phone.ip_address, :path => 'reset.html', :post => {"resetOption" => "0"},:user => phone.http_user, :password => phone.http_password)
    end
    
    return success
  end
  
  def self.reboot_phone_by_http(options = {:ip_address => nil, :port => 80, :path => nil, :post => nil, :user => nil, :password => nil, :ssl => false, :timeout => 5})
    require 'net/http'
    
    http = Net::HTTP.new(options[:ip_address], options[:port])
    if (http)
      http.use_ssl = options[:ssl]
      http.open_timeout = options[:timeout]
      http.read_timeout = options[:timeout]
      if (options[:post])
	request = Net::HTTP::Post.new(options[:path], nil)
	request.set_form_data(options[:post])
      else
	request = Net::HTTP::Get.new(options[:path], nil)
      end
      request.basic_auth(options[:user], options[:password])
      response = http.request(request)

      # TODO Proper exception handling, more response codes
      success = case response.code
	when "200" then true
	when "302" then true
	else false
      end
      return success
    end
  end
end
