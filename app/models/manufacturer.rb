# == Schema Information
# Schema version: 20110119105502
#
# Table name: manufacturers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  ieee_name  :string(255)
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Manufacturer < ActiveRecord::Base
  has_many :vcards, :as => :vcardable, :dependent => :destroy
  has_many :phone_models, :dependent => :destroy
  has_many :ouis, :dependent => :destroy
  has_many :phones, :through => :phone_models
  validates_presence_of :name
  validates_uniqueness_of :name
end
