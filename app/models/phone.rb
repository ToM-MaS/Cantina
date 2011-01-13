class Phone < ActiveRecord::Base
  has_one :description, :as => :descriptionable, :dependent => :destroy
  
  # Internal phonebook
  has_many :vcards, :as => :vcardable, :dependent => :destroy
  
  # Keys
  has_many :phone_keys, :dependent => :destroy
end
