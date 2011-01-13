# == Schema Information
# Schema version: 20110113094740
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
  has_many :sip_account_codecs, :dependent => :destroy
  has_many :codecs, :through => :sip_account_codecs
  
  # Keys
  has_many :phone_keys, :dependent => :destroy
  
  belongs_to :phone, :validate => true
  acts_as_list :scope => :phone
  
  #TODO: Validations
end
