class Oui < ActiveRecord::Base
  validates_presence_of :value
  validates_length_of :value, :is => 6
  
  belongs_to :manufacturer
end
