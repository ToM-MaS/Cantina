# == Schema Information
# Schema version: 20110117122740
#
# Table name: phone_models
#
#  id                               :integer         not null, primary key
#  name                             :string(255)
#  url                              :string(255)
#  manufacturer_id                  :integer
#  max_number_of_sip_accounts       :integer
#  number_of_keys                   :integer
#  max_number_of_phone_book_entries :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#

class PhoneModel < ActiveRecord::Base
  default_value_for :max_number_of_sip_accounts, 1
  default_value_for :number_of_keys, 0
  default_value_for :max_number_of_phone_book_entries, 0
  
  # Validations
  #
  validates_presence_of     :manufacturer_id
  validates_numericality_of :manufacturer_id, :only_integer => true
  
  validates_presence_of     :max_number_of_sip_accounts
  validates_numericality_of :max_number_of_sip_accounts, :only_integer => true, :greater_than_or_equal_to => 1
  
  validates_presence_of     :number_of_keys
  validates_numericality_of :number_of_keys, :only_integer => true, :greater_than_or_equal_to => 0
  
  validates_presence_of     :max_number_of_phone_book_entries
  validates_numericality_of :max_number_of_phone_book_entries, :only_integer => true, :greater_than_or_equal_to => 0
  
  validate :does_a_manufacturer_to_this_phone_model_exist

  # TODO: URL validieren

  # Associations
  #
  belongs_to :manufacturer
  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  has_many :phone_model_keys, :dependent => :destroy
  
  has_many :phone_model_mac_addresses, :dependent => :destroy
  
  private

  def does_a_manufacturer_to_this_phone_model_exist
    if ! Manufacturer.exists?(:id => self.manufacturer_id)
      errors.add(:manufacturer_id, "There is no Manufacturer with the given id #{self.manufacturer_id}.")
    end      
  end
  
end
