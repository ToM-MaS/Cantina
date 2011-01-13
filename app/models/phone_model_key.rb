# == Schema Information
# Schema version: 20110113094740
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
  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  has_many :phone_key_function_definitions
  has_many :phone_keys, :dependent => :destroy
  
  #TODO: Validations
end
