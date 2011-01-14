# == Schema Information
# Schema version: 20110113200244
#
# Table name: sip_accounts
#
#  id                       :integer         not null, primary key
#  name                     :string(255)
#  phone_id                 :integer
#  auth_user                :string(255)
#  user                     :string(255)
#  password                 :string(255)
#  registrar                :string(255)
#  registrar_port           :integer
#  outbound_proxy           :string(255)
#  outbound_proxy_port      :integer
#  sip_proxy                :string(255)
#  sip_proxy_port           :integer
#  realm                    :string(255)
#  screen_name              :string(255)
#  display_name             :string(255)
#  registration_expiry_time :integer
#  dtmf_mode                :string(255)
#  remote_password          :string(255)
#  position                 :integer
#  created_at               :datetime
#  updated_at               :datetime
#

class SipAccount < ActiveRecord::Base
  after_initialize :set_defaults
  
  has_many :sip_account_codecs, :dependent => :destroy
  has_many :codecs, :through => :sip_account_codecs
  
  # Keys
  has_many :phone_keys, :dependent => :destroy
  
  belongs_to :phone, :validate => true
  acts_as_list :scope => :phone
  validates_uniqueness_of :realm, :allow_nil => true
  validates_presence_of :user
  validates_presence_of :phone_id
  validates_numericality_of :phone_id
  validate :does_a_phone_to_this_sip_account_exist
  validate :number_of_sip_accounts_is_possible

private
  def set_defaults
    self.dtmf_mode = 'rfc2833' if self.new_record? and self.dtmf_mode.blank?
  end

  def does_a_phone_to_this_sip_account_exist
    if !Phone.exists?(:id => self.phone_id)
      errors.add(:phone_id, "There is no Phone with the given id #{self.phone_id}.")
    end      
  end
    
  def number_of_sip_accounts_is_possible
    if self.phone.sip_accounts.include?(self)
      my_self = 1
    else
      my_self = 0
    end
    if !self.phone.nil? and !((self.phone.sip_accounts.count - my_self) < self.phone.phone_model.max_number_of_sip_accounts) 
      errors.add(:phone_id, "only #{self.phone.phone_model.max_number_of_sip_accounts} SIP Accounts possible")
    end  
  end

  #TODO: Validations
end
