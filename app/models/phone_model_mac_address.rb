# == Schema Information
# Schema version: 20110121121114
#
# Table name: phone_model_mac_addresses
#
#  id             :integer         not null, primary key
#  phone_model_id :integer
#  starts_with    :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class PhoneModelMacAddress < ActiveRecord::Base
  validates_presence_of :starts_with
  validates_uniqueness_of :starts_with
  validates_length_of :starts_with, :within => 1..12
  validates_format_of :starts_with, :with => /^[0-9A-F]+$/

  belongs_to :phone_model
end
