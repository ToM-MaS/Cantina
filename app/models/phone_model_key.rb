class PhoneModelKey < ActiveRecord::Base
  belongs_to :phone_model
  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  has_many :phone_key_function_definitions
  
  has_many :phone_keys, :dependent => :destroy
end
