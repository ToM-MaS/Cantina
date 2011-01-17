# == Schema Information
# Schema version: 20110113200244
#
# Table name: phones
#
#  id             :integer         not null, primary key
#  mac_address    :string(255)
#  phone_model_id :integer
#  ip_address     :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Phone < ActiveRecord::Base
  # Have a look at http://railscasts.com/episodes/237-dynamic-attr-accessible
  #
  # attr_accessible :mac_address, :phone_model_id, :ip_address
  
  belongs_to :phone_model

  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  
  # Internal phonebook
  has_many :vcards, :as => :vcardable, :dependent => :destroy
  
  # SIP Accounts
  has_many :sip_accounts, :order => "position", :dependent => :destroy
  
  # Validations
  #
  validates_presence_of :mac_address
  validates_format_of :mac_address, :with => /^ [0-9A-F]{2} (?: [:\-]? [0-9A-F]{2} ){5} $/ix
  validates_uniqueness_of :mac_address

  validates_uniqueness_of :ip_address, :allow_nil => true
  validates_format_of :ip_address, :with => /^ (?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d) (?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3} $/x, :allow_nil => true
  
  validates_presence_of :phone_model_id
  validates_numericality_of :phone_model_id
  
  # TODO: Validate that the phone_model with the given phone_model_id exists?
  
  after_validation :format_mac_address
  
  def format_mac_address
    self.mac_address = self.mac_address.to_s.upcase.gsub(/[^A-F0-9]/,'')
  end
  
end
