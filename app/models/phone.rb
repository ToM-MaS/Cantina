class Phone < ActiveRecord::Base
  # Have a look at http://railscasts.com/episodes/237-dynamic-attr-accessible
  #
  attr_accessible :mac_address, :phone_model_id
  
  belongs_to :phone_model

  has_many :descriptions, :as => :descriptionable, :dependent => :destroy
  
  # Internal phonebook
  has_many :vcards, :as => :vcardable, :dependent => :destroy
  
  # Keys
  has_many :phone_keys, :dependent => :destroy

  # SIP Accounts
  has_many :sip_accounts, :order => "position", :dependent => :destroy
  
  # Validations
  #
  validates_presence_of :mac_address
  validates_format_of :mac_address, :with => /^ [0-9A-F]{2} (?: [:]? [0-9A-F]{2} ){5} $/ix
  validates_uniqueness_of :mac_address
  
  validates_presence_of :phone_model_id

  after_validation :format_mac_address
  
  def format_mac_address
    self.mac_address = self.mac_address.to_s.upcase.gsub(/[^A-F0-9]/,'')
  end  
  
end
