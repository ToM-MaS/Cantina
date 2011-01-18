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
  
  validate :validate_url
  
  # Associations
  #
  belongs_to :manufacturer
  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  has_many :phone_model_keys, :dependent => :destroy

  has_many :phone_model_mac_addresses, :dependent => :destroy

  # Find a phone_model by a given MAC Address
  #
  def self.find_by_mac_address(mac_address)
    phone_model = nil
    if !(
      mac_address.class != String or 
      mac_address == nil or 
      mac_address.upcase.gsub(/[^A-F0-9]/,'').length > 12 or 
      mac_address.upcase.gsub(/[^A-F0-9]/,'').length < 7
      )
      mac_address = mac_address.upcase.gsub(/[^A-F0-9]/,'')
      (6 .. mac_address.length).each do |length|
        phone_model_mac_addresses = PhoneModelMacAddress.where(:starts_with => mac_address[0,length])
        phone_model = PhoneModel.where(:id => phone_model_mac_addresses.first).first if !phone_model_mac_addresses.nil?
        break if !phone_model.nil?
      end
    end
    phone_model
  end
  
  private

  def does_a_manufacturer_to_this_phone_model_exist
    if ! Manufacturer.exists?(:id => self.manufacturer_id)
      errors.add(:manufacturer_id, "There is no Manufacturer with the given id #{self.manufacturer_id}.")
    end      
  end
  
  def validate_url()
    if self.url != nil
      require 'uri'
      begin
        uri = URI.parse( self.url )
        if ! uri.absolute?
          errors.add( :url, "is invalid (has to have a scheme)" )
        elsif ! uri.hierarchical?
          errors.add( :url, "is invalid (not hierarchical)" )
        elsif !( uri.is_a?( URI::HTTP ) || uri.is_a?( URI::HTTPS ) )
          errors.add( :url, "is invalid (must have http or https scheme)" )
        end
      rescue URI::InvalidURIError
        errors.add( :url, "is invalid" )
      end
    end
  end
  
end
