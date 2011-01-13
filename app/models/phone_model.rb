class PhoneModel < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  
  has_many :phone_model_keys, :dependent => :destroy
  
end
