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
  default_value_for :dtmf_mode, 'rfc2833'
  
  validates_uniqueness_of :realm, :allow_nil => true
  validates_presence_of :user
  validates_presence_of :phone_id
  validates_numericality_of :phone_id
  validates_inclusion_of :dtmf_mode, :in => ['rfc2833', 'inband', 'info']
  validate :does_a_phone_to_this_sip_account_exist
  validate :number_of_sip_accounts_is_possible

  has_many :sip_account_codecs, :dependent => :destroy
  has_many :codecs, :through => :sip_account_codecs
  
  has_many :phone_keys, :dependent => :destroy

  belongs_to :phone, :validate => true
  acts_as_list :scope => :phone

private
  def does_a_phone_to_this_sip_account_exist
    if !Phone.exists?(:id => self.phone_id)
      errors.add(:phone_id, "There is no Phone with the given id #{self.phone_id}.")
    end      
  end
    
  def number_of_sip_accounts_is_possible
    if !self.phone.nil? and self.phone.sip_accounts.include?(self)
      my_self = 1
    else
      my_self = 0
    end
    if !self.phone.nil? and !((self.phone.sip_accounts.count - my_self) < self.phone.phone_model.max_number_of_sip_accounts) 
      errors.add(:phone_id, "only #{self.phone.phone_model.max_number_of_sip_accounts} SIP Accounts for the Phone with the ID #{self.phone.id} possible")
    end  
  end

  #TODO: Validations
  
  # Validate auth_user. This is the "user" rule from RFC 3261.
  validates_format_of :auth_user , :with => /^(?: (?: [A-Za-z0-9] | [\-_.!~*'()] )| %[0-9A-F]{2} | [&=+$,;?\/] ){1,255}$/x, :allow_nil => true, :allow_blank => false
  
  # Validate user. This is the "user" rule from RFC 3261.
  validates_format_of :user      , :with => /^(?: (?: [A-Za-z0-9] | [\-_.!~*'()] )| %[0-9A-F]{2} | [&=+$,;?\/] ){1,255}$/x#, :allow_nil => false, :allow_blank => false
  
  
  # Validate password, remote_password. This is the "password" rule from RFC 3261.
  validates_format_of [ :password, :remote_password ], :with => /^(?: (?: [A-Za-z0-9] | [\-_.!~*'()] )| %[0-9A-F]{2} | [&=+$,] ){0,255}$/x, :allow_nil => true, :allow_blank => true
  
  # Validate registrar, outbound_proxy, sip_proxy. This is the "host" rule from RFC 3261
  # (but the patterns for IPv4 and IPv6 addresses have been fixed here).
  validates_format_of [ :registrar, :outbound_proxy, :sip_proxy ], :with =>
    /^
      (?:
        (?:
          (?:
            (?:
              [A-Za-z0-9] |
              [A-Za-z0-9] [A-Za-z0-9\-]* [A-Za-z0-9]
            ) \.
          )*
          (?:
            [A-Za-z] |
            [A-Za-z] [A-Za-z0-9\-]* [A-Za-z0-9]
          ) \.?
        ) |
        (?:
          (?: 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d )
          (?: \. (?: 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d ) ){3}
        )
      ) |
      (
        (
          ( [0-9A-Fa-f]{1,4} : ){7} ( [0-9A-Fa-f]{1,4} | : )
        )|
        (
          ( [0-9A-Fa-f]{1,4} : ){6}
          (
            :[0-9A-Fa-f]{1,4} |
            (
              ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d )
              ( \. ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d ) ){3}
            ) | :
          )
        )|
        (
          ( [0-9A-Fa-f]{1,4} : ){5}
            (
              (
                ( : [0-9A-Fa-f]{1,4} ){1,2}
              )|
              :(
                ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d )
                ( \. ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d ) ){3}
              )|
              :
            )
        )|
        (
          ( [0-9A-Fa-f]{1,4} : ){4}
          (
            ( ( : [0-9A-Fa-f]{1,4} ){1,3} ) |
            (
              ( : [0-9A-Fa-f]{1,4} )? :
              (
                ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d )
                ( \. ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d ) ){3}
              )
            ) | :
          )
        )|
        (
          ( [0-9A-Fa-f]{1,4} : ){3}
          (
            ( ( : [0-9A-Fa-f]{1,4} ){1,4} ) |
            (
              ( : [0-9A-Fa-f]{1,4} ){0,2} :
              (
                ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d )
                ( \. ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d ) ){3}
              )
            ) | :
          )
        )|
        (
          ( [0-9A-Fa-f]{1,4} : ){2}
          (
            ( ( : [0-9A-Fa-f]{1,4} ){1,5} ) |
            (
              ( : [0-9A-Fa-f]{1,4} ){0,3} :
              (
                ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d )
                ( \. ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d ) ){3}
              )
            ) | :
          )
        )|
        (
          ( [0-9A-Fa-f]{1,4} : ){1}
          (
            ( ( : [0-9A-Fa-f]{1,4} ){1,6} ) |
            (
              ( : [0-9A-Fa-f]{1,4} ){0,4} :
              (
                ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d )
                ( \. ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d ) ){3}
              )
            ) | :
          )
        )|
        (
          :(
            ( ( : [0-9A-Fa-f]{1,4} ){1,7} ) |
            (
              ( : [0-9A-Fa-f]{1,4} ){0,5} :
              (
                ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d )
                ( \. ( 25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d ) ){3}
              )
            ) | :
          )
        )
      )
    $/x, :allow_nil => true, :allow_blank => true
  
  # Validate registrar_port, outbound_proxy_port, sip_proxy_port
  validates_numericality_of [ :registrar_port, :outbound_proxy_port, :sip_proxy_port ], :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 65535, :allow_nil => true, :allow_blank => true
  
  # Validate registration_expiry_time
  validates_numericality_of :registration_expiry_time, :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 65535, :allow_nil => true, :allow_blank => true
  
  # Validate display_name
  validate :validate_display_name
  
  #Validate realm
  validate :validate_realm
  
  def validate_quoted_pair( val )
   ret = true
   if val != nil
      if ! /^(?:
               (?:
                  (?: (?: [\x20\x09]* \x0D\x0A )? [\x20\x09]{1,} ) |
                  [\x21\x23-\x5B\x5D-\x7E] |
                  x
                ) |
                (?: [\\] [\x00-\x09\x0B-\x0C\x0E-\x7F] )
              )*
            $/x.match( val.dup.force_encoding('BINARY') )
        ret = false
      end
    end
    return ret
  end
  
  def validate_display_name
    if ! validate_quoted_pair( self.display_name )
      errors.add( :display_name , "Invalid display name (see RFC 3261)." )
    end
  end
  
  def validate_realm
    if ! validate_quoted_pair( self.realm )
      errors.add( :realm        , "Invalid realm (see RFC 3261)." )
    end
  end
  
end
