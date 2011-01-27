# Import the OUI List for the Phone Manufacturer MAC Address list
# http://standards.ieee.org/develop/regauth/oui36/index.html
#
# require 'open-uri'
# oui_input = Array.new
# open('http://standards.ieee.org/develop/regauth/oui/oui.txt') {|f|
#   f.each_line do |line|
#     if (line =~ /Snom/i) != nil
#       parts = line.partition(/   \(hex\)\t\t/)
#       if (parts[0] =~ /[A-Z0-9]{2}-[A-Z0-9]{2}-[A-Z0-9]{2}/) == 0 and parts[2].chomp != nil
#         manufacturer = Manufacturer.find_or_create_by_ieee_name(parts[2].chomp)
#         manufacturer.update_attributes(:name => parts[2].chomp) if manufacturer.name.blank?
#         manufacturer.ouis.create(:value => parts[0].upcase.gsub(/[^A-F0-9]/,''))
#       end
#     end
#   end
# }

# To make it a bit faster we'll include a couple of the manufacturers here:
#
Manufacturer.find_or_create_by_ieee_name('SNOM Technology AG', :name => 'SNOM Technology AG', :url => 'http://www.snom.com/').ouis.create(:value => '000413')
Manufacturer.find_or_create_by_ieee_name('DeTeWe-Deutsche Telephonwerke', :name => 'AASTRA DeTeWe', :url => 'http://www.detewe.de/').ouis.create(:value => '003042')
Manufacturer.find_or_create_by_ieee_name('DeTeWe-Deutsche Telephonwerke', :name => 'AASTRA DeTeWe', :url => 'http://www.detewe.de/').ouis.create(:value => '00085d')
Manufacturer.find_or_create_by_ieee_name('XIAMEN YEALINK NETWORK TECHNOLOGY CO.,LTD', :name => 'Tiptel', :url => 'http://www.tiptel.de/').ouis.create(:value => '001565')


Codec.create(:name => 'gsm')
Codec.create(:name => 'ulaw')
Codec.create(:name => 'alaw')
Codec.create(:name => 'g722')
Codec.create(:name => 'g723')
Codec.create(:name => 'g726')
Codec.create(:name => 'g729')
Codec.create(:name => 'ilbc')
Codec.create(:name => 'speex')
Codec.create(:name => 'lpc10')
Codec.create(:name => 'slin')
Codec.create(:name => 'adpcm')
Codec.create(:name => 'amr')
Codec.create(:name => 'h261')
Codec.create(:name => 'h263')
Codec.create(:name => 'h263+')
Codec.create(:name => 'h264')

# Softkey functions:
# DO NOT RENAME THEM! The name is magic and serves as an identifier!
#
PhoneKeyFunctionDefinition.create([
  { :name => 'BLF'              , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'Speed dial'       , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'ActionURL'        , :type_of_class => 'url'     , :regex_validation => nil },
  { :name => 'Line'             , :type_of_class => 'integer' , :regex_validation => nil },
  
])

# Phone Models
#

# Snom
# http://wiki.snom.com/Settings/mac
#
snom = Manufacturer.where(:ieee_name => 'SNOM Technology AG').first
snom.phone_models.create(:name => 'Snom 190').phone_model_mac_addresses.create(:starts_with => '00041322')
snom300 = snom.phone_models.create(:name => 'Snom 300', 
                                   :url => 'http://www.snom.com/en/products/ip-phones/snom-300/',
                                   :max_number_of_sip_accounts =>  2 )
snom300.phone_model_mac_addresses.create([
                                         {:starts_with => '00041325'},
                                         {:starts_with => '00041328'},
                                         {:starts_with => '0004132D'},
                                         {:starts_with => '0004132F'},
                                         {:starts_with => '00041334'},
                                         {:starts_with => '00041350'},
                                         {:starts_with => '0004133B'},
                                         {:starts_with => '00041337'}
                                         ])
# Uncomment the following code if you need all Snom 300 MAC Addresses
# It'll fill your database by some 30,000 items.
#                                                                                
# ('0004133687F0'.hex .. '00041336FFFF'.hex).each do |snom300_mac_address|
#   snom300_mac_address = snom300_mac_address.to_s(16)
#   (snom300_mac_address.length .. 11).each do |i|
#     snom300_mac_address = '0' + snom300_mac_address
#   end
#   snom300.phone_model_mac_addresses.create(:starts_with => snom300_mac_address.upcase)
# end
snom.phone_models.create(:name => 'Snom 320', 
                         :url => 'http://www.snom.com/en/products/ip-phones/snom-320/',
                         :max_number_of_sip_accounts => 12,
                         :number_of_keys => 12 ).
                         phone_model_mac_addresses.create([
                           {:starts_with => '00041324'},
                           {:starts_with => '00041327'},
                           {:starts_with => '0004132C'},
                           {:starts_with => '00041331'},
                           {:starts_with => '00041335'},
                           {:starts_with => '00041338'},
                           {:starts_with => '00041351'}
                                         ])
snom.phone_models.create(:name => 'Snom 360', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-360/',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
                        phone_model_mac_addresses.create([
                          {:starts_with => '00041323'},
                          {:starts_with => '00041329'},
                          {:starts_with => '0004132B'},
                          {:starts_with => '00041339'},
                          {:starts_with => '00041390'}
                                        ])
snom.phone_models.create(:name => 'Snom 370', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-370/',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
                        phone_model_mac_addresses.create([
                          {:starts_with => '00041326'},
                          {:starts_with => '0004132E'},
                          {:starts_with => '0004133A'},
                          {:starts_with => '00041352'}
                                        ])
snom.phone_models.create(:name => 'Snom 820', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-820/',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
                        phone_model_mac_addresses.create([
                          {:starts_with => '00041326'},
                          {:starts_with => '0004132E'},
                          {:starts_with => '0004133A'},
                          {:starts_with => '00041352'}
                                        ])
snom.phone_models.create(:name => 'Snom 821', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-821/',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
                        phone_model_mac_addresses.create([
                          {:starts_with => '00041345'}
                                        ])
snom.phone_models.create(:name => 'Snom 870', 
                        :url => 'http://www.snom.com/en/products/ip-phones/snom-870/',
                        :max_number_of_sip_accounts => 12,
                        :number_of_keys => 12 ).
                        phone_model_mac_addresses.create([
                          {:starts_with => '00041341'}
                                        ])
# Define Snom keys:
snom.phone_models.each do |pm|
	num_exp_modules = 0	
	max_key_idx = pm.number_of_keys.to_i + (42 * num_exp_modules) - 1
	if max_key_idx >= 0
		(0..max_key_idx).each { |idx|
			key = pm.phone_model_keys.create(
				{ :position => idx, :name => "P #{(1+idx).to_s.rjust(3,'0')} (fkey[#{idx}])" }
			)
			key.phone_key_function_definitions << PhoneKeyFunctionDefinition.all 
		}
	end
end

snom.phone_models.each do |phone_model|
  phone_model.update_attributes(:http_port => 80, :reboot_request_path => 'confirm.htm?REBOOT=yes', :http_request_timeout => 5)
end

Manufacturer.where(
  :ieee_name => 'DeTeWe-Deutsche Telephonwerke'
).first.phone_models.create([
  { :name => '57i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  30 },
  { :name => '55i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  26 },
  { :name => '53i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  6 },
  { :name => '51i' }
])

Manufacturer.where(
  :ieee_name => 'XIAMEN YEALINK NETWORK TECHNOLOGY CO.,LTD'
).first.phone_models.create([
  { :name => 'IP 286', :max_number_of_sip_accounts => 16, :number_of_keys => 10 },
  { :name => 'IP 280', :max_number_of_sip_accounts => 2 },
  { :name => 'IP 284', :max_number_of_sip_accounts => 13, :number_of_keys => 10 },
  { :name => 'VP 28' },
  { :name => 'IP 28 XS' }
])



# Codecs for phone_models
#
PhoneModel.all.each do |phone_model|
  phone_model.codecs << Codec.all
end

# Sample Phones (Testphones Sascha)

PhoneModel.where(
  :name => 'IP 284' 
).first.phones.create([
  { :mac_address => '00156513EC2F' } 
])


# FIXME - removeme: Philipp's test phones:
Phone.create(
  :mac_address    => '00-04-13-29-68-87',
  :phone_model_id => PhoneModel.where( :name => 'Snom 360' ).first.id
)



# ...

['IP 284', 'IP 286'].each do |p_model|
  (1..10).each { |mem_num| 
    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.create([
      { :name => "memory#{mem_num}", :position => "#{mem_num}" }
    ])
    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.where( :name => "memory#{mem_num}" ).first.phone_key_function_definitions << PhoneKeyFunctionDefinition.all

  }

end

# Aastra softkeys
['55i', '57i'].each do |p_model|
 (1..20).each { |mem_num| 
    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.create([
      { :name => "softkey#{mem_num}", :position => "#{mem_num}" }
    ])
    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.where( :name => "softkey#{mem_num}" ).first.phone_key_function_definitions << PhoneKeyFunctionDefinition.all

  } 
end

#Aastra topsoftkeys
['57i'].each do |p_model|
 (1..10).each { |mem_num| 
    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.create([
      { :name => "topsoftkey#{mem_num}", :position => "#{mem_num+20}" }
    ])
    PhoneModel.where( :name => "#{p_model}" ).first.phone_model_keys.where( :name => "topsoftkey#{mem_num}" ).first.phone_key_function_definitions << PhoneKeyFunctionDefinition.all

  } 
end

PhoneModel.where(
  :name => '57i' 
).first.phones.create([
  { :mac_address => '00085D24387A' } 
])
PhoneModel.where(
  :name => 'Snom 320' 
).first.phones.create([
  { :mac_address => '000413271FDB' } 
])
PhoneModel.where(
  :name => 'Snom 320' 
).first.phones.create([
  { :mac_address => '000413271FD8' } 
])

