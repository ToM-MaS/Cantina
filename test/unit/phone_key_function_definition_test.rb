require 'test_helper'

class PhoneKeyFunctionDefinitionTest < ActiveSupport::TestCase
  
  should "be valid" do
    assert Factory.build(:phone_key_function_definition).valid?
  end
  
  
  # Test valid type_of_class
  [
    'string',
    'integer',
    'boolean',
    'url',
    'uri',
  ].each do |type_of_class|
    should "allow #{type_of_class.inspect} as type_of_class" do
      assert Factory.build( :phone_key_function_definition, :type_of_class => type_of_class ).valid?
    end
  end
  
  # Test invalid type_of_class
  [
    'String',
    'Str',
    'str',
    'Integer',
    'Int',
    'int',
    'FixNum',
    'Fixnum',
    'fixnum',
    'Boolean',
    'Bool',
    'bool',
    'Url',
    'URL',
    'Uri',
    'URI',
    '',
    nil,
    'Object',
  ].each do |type_of_class|
    should "not allow #{type_of_class.inspect} as type_of_class" do
      assert ! Factory.build( :phone_key_function_definition, :type_of_class => type_of_class ).valid?
    end
  end
  
  
end
