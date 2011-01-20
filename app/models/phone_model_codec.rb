# == Schema Information
# Schema version: 20110120120511
#
# Table name: phone_model_codecs
#
#  id             :integer         not null, primary key
#  phone_model_id :integer
#  codec_id       :integer
#  position       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class PhoneModelCodec < ActiveRecord::Base
  belongs_to :phone_model
  belongs_to :codec
  
  acts_as_list :scope => :phone_model

  # TODO validation
end
