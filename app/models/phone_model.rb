# == Schema Information
# Schema version: 20110113094740
#
# Table name: phone_models
#
#  id                               :integer         not null, primary key
#  name                             :string(255)
#  manufacturer_id                  :integer
#  max_number_of_sip_accounts       :integer
#  number_of_keys                   :integer
#  max_number_of_phone_book_entries :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#

class PhoneModel < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  has_many :phone_model_keys, :dependent => :destroy
  
  #TODO: Validations
end
