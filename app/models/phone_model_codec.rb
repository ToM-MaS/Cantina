class PhoneModelCodec < ActiveRecord::Base
  belongs_to :phone_model
  belongs_to :codec
  
  acts_as_list :scope => :phone

  # TODO validation
end
