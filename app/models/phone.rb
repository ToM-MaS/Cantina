# == Schema Information
# Schema version: 20110120120511
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

  validates_uniqueness_of :ip_address, :allow_nil => true
  validates_format_of :ip_address, :with => /^ (?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d) (?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3} $/x, :allow_blank => true, :allow_nil => true
  
  validates_presence_of :phone_model_id
  validates_numericality_of :phone_model_id
  
  validate :validate_phone_model_exists
  
  after_validation :format_mac_address
  
  # Have a look at http://railscasts.com/episodes/237-dynamic-attr-accessible
  #
  # attr_accessible :mac_address, :phone_model_id, :ip_address
  
  belongs_to :phone_model

  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  
  # SIP Accounts
  has_many :sip_accounts, :order => 'position', :dependent => :destroy
  
  # History
  has_many :provisioning_log_entries, :order => 'created_at'
  
  # TODO muss noch getestet werden
  # log a provisioning
  def log_provisioning(memo = nil, succeeded = true)
    self.provisioning_log_entries.create(:memo => memo, :succeeded => true)
  end
  
  private
  def format_mac_address
    self.mac_address = self.mac_address.to_s.upcase.gsub(/[^A-F0-9]/,'')
  end
  
  def validate_phone_model_exists()
    if ! PhoneModel.exists?( :id => self.phone_model_id )
      errors.add( :phone_model_id, "There is no phone model with the given ID #{self.phone_model_id}." )
    end
  end
  
end
