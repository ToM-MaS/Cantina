namespace :phone do
  desc "Reboot a phone specified by it's IP odr MAX address"
  task :reboot, :phone, :needs => :environment do |task_name, args|
    if (ip_address_valid(args[:phone]))
      phone = Phone.find_by_ip_address(args[:phone])
      if (phone.class == Phone && ip_address_valid(phone.ip_address))
	success = RebootRequest.trigger_reboot(phone.mac_address)
      else
	abort("ERROR: No phone found with IP #{args[:phone]}")
      end
    elsif (mac_address_valid(args[:phone]))
      success = RebootRequest.trigger_reboot(args[:phone])
    else
      abort("ERROR: No phone specified")
    end
    if (success == false) 
      abort("Reboot failed for phone \"#{args[:phone]}\"")
    else
      puts "Phone \"#{args[:phone]}\" performing reboot"
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

end