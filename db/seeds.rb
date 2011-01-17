# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


# Import the OUI List for the Phone Manufacturer MAC Address list
# http://standards.ieee.org/develop/regauth/oui36/index.html
#
require 'open-uri'
oui_input = Array.new
open('http://standards.ieee.org/develop/regauth/oui/oui.txt') {|f|
  f.each_line do |line|
    parts = line.partition(/   \(hex\)\t\t/)
    if (parts[0] =~ /[A-Z0-9]{2}-[A-Z0-9]{2}-[A-Z0-9]{2}/) == 0 and parts[2].chomp != nil
      manufacturer = Manufacturer.find_or_create_by_ieee_name(parts[2].chomp)
      manufacturer.update_attributes(:name => parts[2].chomp) if manufacturer.name.blank?
      manufacturer.ouis.create(:value => parts[0].upcase.gsub(/[^A-F0-9]/,''))
      puts "#{manufacturer.name} => #{Manufacturer.where(:id => manufacturer.id).first.ouis.count}"
    end
  end
}

Language.create(:name => 'Deutsch')
Language.create(:name => 'English')

Codec.create(:name => 'GSM')
Codec.create(:name => 'ulaw')
Codec.create(:name => 'alaw')

# Phone Models
#
Manufacturer.where(
  :ieee_name => 'SNOM Technology AG'
).first.phone_models.create([
  { :name => 'Snom 360', :max_number_of_sip_accounts => 12, :number_of_keys => 12 },
  { :name => 'Snom 370', :max_number_of_sip_accounts => 12, :number_of_keys => 12 },
  { :name => 'Snom 320', :max_number_of_sip_accounts => 12, :number_of_keys => 12 },
  { :name => 'Snom 300', :max_number_of_sip_accounts =>  2 },
  { :name => 'Snom 821', :max_number_of_sip_accounts => 12, :number_of_keys =>  8 },
  { :name => 'Snom 820', :max_number_of_sip_accounts => 12, :number_of_keys =>  8 },
  { :name => 'Snom 871', :max_number_of_sip_accounts => 12, :number_of_keys =>  8 }
])
# http://wiki.snom.com/Settings/mac

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