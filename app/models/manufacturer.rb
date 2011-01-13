class Manufacturer < ActiveRecord::Base
  has_many :vcards, :as => :vcardable, :dependent => :destroy
end
