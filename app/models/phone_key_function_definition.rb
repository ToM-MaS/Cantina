# == Schema Information
# Schema version: 20110120120511
#
# Table name: phone_key_function_definitions
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  type_of_class    :string(255)
#  regex_validation :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class PhoneKeyFunctionDefinition < ActiveRecord::Base
  belongs_to :phone_model_key
  has_many :phone_keys, :dependent => :destroy
  
  validates_presence_of  :type_of_class
  validates_inclusion_of :type_of_class, :in => [
    'string',
    'integer',
    'boolean',
    'url',
    'uri',
  ]
  
  validate :validate_regex_validation
    
  private
  
  # Validates the regex_validation of the PhoneKeyFunctionDefinition.
  def validate_regex_validation()
    if self.regex_validation != nil
      begin
        re = Regexp.new( self.regex_validation )
      rescue RegexpError
        errors.add( :regex_validation, "is invalid." )
      end
    end
  end
    
end
