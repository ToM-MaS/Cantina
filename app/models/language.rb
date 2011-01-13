class Language < ActiveRecord::Base
  has_many :translations
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
