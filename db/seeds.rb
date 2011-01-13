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
