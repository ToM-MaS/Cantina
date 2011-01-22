# == Schema Information
# Schema version: 20110121121114
#
# Table name: phones
#
#  id             :integer         not null, primary key
#  mac_address    :string(255)
#  phone_model_id :integer
#  ip_address     :string(255)
#  http_user      :string(255)
#  http_password  :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Phone < ActiveRecord::Base
  # Validations
  #
  validates_presence_of :mac_address
  validates_format_of :mac_address, :with => /^ [0-9A-F]{2} (?: [:\-]? [0-9A-F]{2} ){5} $/ix
  validates_uniqueness_of :mac_address

  validates_uniqueness_of :ip_address, :allow_nil => true, :allow_blank => true
  validates_format_of :ip_address, :with => /^ (?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d) (?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3} $/x, :allow_blank => true, :allow_nil => true
  # TODO test for '' as not unqiueness
  
  validates_presence_of :phone_model_id
  validates_numericality_of :phone_model_id
  
  validate :validate_phone_model_exists
  
  after_validation :format_mac_address
  
  # SIP Accounts
  has_many :sip_accounts, :order => 'position', :dependent => :destroy
  
  # PhoneKeys for shorter access 
  has_many :phone_keys, :through => :sip_accounts
 
  # History
  has_many :provisioning_log_entries, :order => 'created_at'

  # Belongs to a phone_model
  belongs_to :phone_model
  
  # Can be rebooted
  has_many :reboot_requests, :order => 'start', :dependent => :destroy

  # TODO muss noch getestet werden
  # log a provisioning
  def log_provisioning(memo = nil, succeeded = true)
    self.provisioning_log_entries.create(:memo => memo, :succeeded => true)
  end
  
  private
  
  # Formats a MAC address.
  def format_mac_address
    self.mac_address = self.mac_address.to_s.upcase.gsub(/[^A-F0-9]/,'')
  end
  
  # Validates if the phone model exists.
  def validate_phone_model_exists()
    if ! PhoneModel.exists?( :id => self.phone_model_id )
      errors.add( :phone_model_id, "There is no phone model with the given ID #{self.phone_model_id}." )
    end
  end
  
end
