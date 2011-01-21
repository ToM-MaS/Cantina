# == Schema Information
# Schema version: 20110120120511
#
# Table name: phone_keys
#
#  id                               :integer         not null, primary key
#  phone_model_key_id               :integer
#  phone_key_function_definition_id :integer
#  value                            :string(255)
#  created_at                       :datetime
#  updated_at                       :datetime
#  sip_account_id                   :integer
#

class PhoneKey < ActiveRecord::Base
	belongs_to :sip_account
	belongs_to :phone_model_key
	belongs_to :phone_key_function_definition
	
	validates_presence_of      :value
	validates_presence_of      :phone_key_function_definition_id
	validates_numericality_of  :phone_key_function_definition_id, :only_integer => true
	validates_presence_of :sip_account_id
  validates_numericality_of :sip_account_id, :only_integer => true
  #TODO Validate Only existing sip_account_id
	# is this a good way?:
	#validates_presence_of      :phone_key_function_definition
	
	validate :validate_softkey
	
	private
	
	# Validates the softkey definition.
	def validate_softkey
		if self.phone_key_function_definition == nil
			errors.add( :phone_key_function_definition, "cannot be nil." )
		else
			case self.phone_key_function_definition.type_of_class
				
				when 'string'
					if ! self.value.class.ancestors.include?( String )
						errors.add( :value, "(\"#{self.value}\") for \"#{self.phone_key_function_definition.name}\" softkey has to be a string." )
					end
				
				when 'integer'
					if ! self.value.match( /^\-?[0-9]{1,9}$/ )
						errors.add( :value, "(\"#{self.value}\") for \"#{self.phone_key_function_definition.name}\" softkey has to be numerical." )
					end
				
				when 'boolean'
					if ! self.value.match( /^(?:true|false)$/ )
						errors.add( :value, "(\"#{self.value}\") for \"#{self.phone_key_function_definition.name}\" softkey has to be boolean (\"true\" or \"false\")." )
					end
				
				when 'url'
					require 'uri'
					begin
						uri = URI.parse( self.value )
						# Require an absolute URI (i.e. with a scheme):
						if ! uri.absolute?
							errors.add( :value, "(\"#{self.value}\") for \"#{self.phone_key_function_definition.name}\" softkey has to be an URL with a scheme." )
						end
					rescue URI::InvalidURIError
						errors.add( :value, "(\"#{self.value}\") for \"#{self.phone_key_function_definition.name}\" softkey has to be an URL." )
					end
				
				when 'uri'
					require 'uri'
					begin
						uri = URI.parse( self.value )
						# Strictly speaking, if the thing has a fragment ("#frag")
						# then it's not a "URI" (but maybe a "URI-reference").
						if ! uri.fragment.nil?
							errors.add( :value, "(\"#{self.value}\") for \"#{self.phone_key_function_definition.name}\" softkey has to be an URI (URI's don't have a fragment)." )
						end
					rescue URI::InvalidURIError
						errors.add( :value, "(\"#{self.value}\") for \"#{self.phone_key_function_definition.name}\" softkey has to be an URI." )
					end
				
				else
					errors.add( :'phone_key_function_definition.type_of_class',
						"(\"#{self.phone_key_function_definition.type_of_class}\") is not validatable for softkey function type \"#{self.phone_key_function_definition.name}\"." )
			end
			
			if ! self.phone_key_function_definition.regex_validation.blank?
				re = Regexp.new( self.phone_key_function_definition.regex_validation )
				if ! re.match( self.value )
					errors.add( :value, "(\"#{self.value}\") does not match the required format for softkey function type \"#{self.phone_key_function_definition.name}\"." )
				end
			end
		end
	end
		
end
