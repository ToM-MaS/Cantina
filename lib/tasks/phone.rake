namespace :phone do
  desc "Reboot a specific phone"
  task :reboot, :phone, :needs => :environment do |task_name, args|
    success = false
    if (ip_address_valid(args[:phone]))
      phone = retrieve_phone_info(:ip_address => args[:phone])
      if (phone.class == Phone && ip_address_valid(phone.ip_address))
	success = reboot_phone(phone)
      else
	abort("ERROR: No phone found")
      end
    elsif (mac_address_valid(args[:phone]))
      phone = retrieve_phone_info(:mac_address => args[:phone])
      if (phone.class == Phone && ip_address_valid(phone.ip_address))
	success = reboot_phone(phone)
      else
	abort("ERROR: No phone found")
      end
    else
      abort("ERROR: No phone specified")
    end
    if (success == false) 
      abort("Reboot failed")
    end
  end

  def ip_address_valid(ip_address)
    if (ip_address =~ /^ (?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d) (?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3} /x)
      return true
    end
    return false
  end

  def mac_address_valid(mac_address)
    if (mac_address =~ /^ [0-9A-F]{2} (?: [:\-]? [0-9A-F]{2} ){5} $/ix)
      return true
    end
    return false
  end

  def retrieve_phone_info(options = {:ip_address => nil, :mac_address => nil})
    if (options[:mac_address])
      phone = Phone.find_by_mac_address(options[:mac_address].upcase())
    elsif (options[:ip_address])
      phone = Phone.find_by_ip_address(options[:ip_address])
    else
      return nil
    end
    return phone
  end

  def reboot_phone(phone)
    #TODO: Different reboot behavior according to phone model
      
    if (phone.class != Phone)
      return false
    end
    print "Rebooting phone #{phone.ip_address} of type #{phone.phone_model_id} - "
    success = reboot_phone_by_http(:ip_address => phone.ip_address, :path => 'confirm.htm?REBOOT=yes', :user => phone.http_user, :password => phone.http_password)
    if (success)
      puts "OK"
    else
      puts "ERROR"
    end
    return success
  end

  def reboot_phone_by_http(options = {:ip_address => nil, :port => 80, :path => nil, :user => nil, :password => nil, :ssl => false, :timeout => 5})
    require 'net/http'
    
    http = Net::HTTP.new(options[:ip_address], options[:port])
    if (http)
      http.use_ssl = options[:ssl]
      http.open_timeout = options[:timeout]
      http.read_timeout = options[:timeout]
      request = Net::HTTP::Get.new(options[:path], nil)
      request.basic_auth(options[:user], options[:password])
      response = http.request(request)
      
      # TODO: Proper exception handling, more response codes
      success = case response.code
	when "200" then true
	when "302" then true
	else false
      end
      return success
    end
  end

end