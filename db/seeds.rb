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
Manufacturer.find_or_create_by_ieee_name('SNOM Technology AG', :name => 'SNOM Technology AG').ouis.create(:value => '000413')
Manufacturer.find_or_create_by_ieee_name('DeTeWe-Deutsche Telephonwerke', :name => 'DeTeWe').ouis.create(:value => '003042')
Manufacturer.find_or_create_by_ieee_name('XIAMEN YEALINK NETWORK TECHNOLOGY CO.,LTD', :name => 'XIAMEN YEALINK NETWORK TECHNOLOGY CO.,LTD').ouis.create(:value => '001565')
Manufacturer.find_or_create_by_ieee_name('Grandstream Networks, Inc.', :name => 'Grandstream Networks, Inc.').ouis.create(:value => '000B82')

Language.create(:name => 'Deutsch')
Language.create(:name => 'English')

Codec.create(:name => 'GSM')
Codec.create(:name => 'ulaw')
Codec.create(:name => 'alaw')

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

Manufacturer.where(
  :ieee_name => 'DeTeWe-Deutsche Telephonwerke'
).first.phone_models.create([
  { :name => '57i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  30, :max_number_of_phone_book_entries => 200 },
  { :name => '55i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  26, :max_number_of_phone_book_entries => 200 },
  { :name => '53i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  6, :max_number_of_phone_book_entries => 200 },
  { :name => '51i' }
])

Manufacturer.where(
  :ieee_name => 'XIAMEN YEALINK NETWORK TECHNOLOGY CO.,LTD'
).first.phone_models.create([
  { :name => 'IP 286', :max_number_of_sip_accounts => 16 },
  { :name => 'IP 280', :max_number_of_sip_accounts => 2 },
  { :name => 'IP 284', :max_number_of_sip_accounts => 13 },
  { :name => 'VP 28' },
  { :name => 'IP 28 XS' }
])

Manufacturer.where(
  :ieee_name => 'Grandstream Networks, Inc.'
).first.phone_models.create([
  { :name => 'GXP 280' },
  { :name => 'GXP 1200' },
  { :name => 'GXP 2000' },
  { :name => 'GXP 2010' },
  { :name => 'GXP 2020' },
  { :name => 'GXV 3000' },
  { :name => 'GXV 3005' },
  { :name => 'GXV 3140' },
])


# Softkey functions:
#
PhoneKeyFunctionDefinition.create([
  { :name => 'BLF'              , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'Speed dial'       , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'ActionURL'        , :type_of_class => 'url'     , :regex_validation => nil },
  { :name => 'Line'             , :type_of_class => 'integer' , :regex_validation => nil },
  { :name => 'Phone-spec. fn.'  , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'Label'            , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'XML'              , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'Intercom'         , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'Parking'          , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'Recording'        , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'DTMF'             , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'PTT'              , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'Button'           , :type_of_class => 'integer' , :regex_validation => nil },
  { :name => 'Presence'         , :type_of_class => 'url'     , :regex_validation => nil },
  { :name => 'Transfer'         , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'Redirect'         , :type_of_class => 'string'  , :regex_validation => nil },
  { :name => 'Auto-answer'      , :type_of_class => 'integer' , :regex_validation => nil },
  { :name => 'Def. function?'   , :type_of_class => 'boolean' , :regex_validation => nil },
])

# Sample Phones (Testphones Sascha)

PhoneModel.where(
  :name => 'IP 284' 
).first.phones.create([
  { :mac_address => '00156513EC2F' } 
])
(1..10).each { |mem_num| 
  PhoneModel.where( :name => 'IP 284' ).first.phone_model_keys.create([
    { :name => "memory#{mem_num}", :position => "#{mem_num}" } 
  ]) }
