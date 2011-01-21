# == Schema Information
# Schema version: 20110120120511
#
# Table name: phone_model_keys
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  phone_model_id :integer
#  position       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class PhoneModelKey < ActiveRecord::Base
  belongs_to :phone_model
  has_many :phone_key_to_function_mappings
  has_many :phone_key_function_definitions, :through => :phone_key_to_function_mappings
  has_many :phone_keys, :dependent => :destroy
  
  validates_presence_of     :phone_model_id
  validates_numericality_of :phone_model_id, :only_integer => true
  
  validates_presence_of     :position
  validates_numericality_of :position, :only_integer => true, :greater_than_or_equal_to => 0
  
  
  # TODO acts_as_list
end
