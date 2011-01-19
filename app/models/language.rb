# == Schema Information
# Schema version: 20110119105502
#
# Table name: languages
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Language < ActiveRecord::Base
  has_many :translations
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
