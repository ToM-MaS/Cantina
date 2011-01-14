# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Language.create(:name => 'Deutsch')
Language.create(:name => 'English')

Codec.create(:name => 'GSM')
Codec.create(:name => 'ulaw')
Codec.create(:name => 'alaw')

Manufacturer.create(:name => 'Snom')
Manufacturer.create(
	:name => 'Aastra'
).phone_models.create([
	{ :name => '57i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  30, :max_number_of_phone_book_entries => 200 },
	{ :name => '55i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  26, :max_number_of_phone_book_entries => 200 },
	{ :name => '53i',  :max_number_of_sip_accounts => 9, :number_of_keys =>  6, :max_number_of_phone_book_entries => 200 },
	{ :name => '51i' }
])
Manufacturer.create(:name => 'Tiptel')
Manufacturer.create(:name => 'Grandstream')

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


