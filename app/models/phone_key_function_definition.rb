class PhoneKeyFunctionDefinition < ActiveRecord::Base
  belongs_to :phone_model_key
  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  
  has_many :phone_keys, :dependent => :destroy
end
