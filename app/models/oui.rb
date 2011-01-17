# == Schema Information
# Schema version: 20110117122740
#
# Table name: ouis
#
#  id              :integer         not null, primary key
#  value           :string(255)
#  manufacturer_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Oui < ActiveRecord::Base
  validates_presence_of :value
  validates_length_of :value, :is => 6
  
  belongs_to :manufacturer
end
