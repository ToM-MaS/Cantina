# encoding: utf-8

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:language).valid?
  end
  
  # A language name must be unique
  should "not be valid with not unique name" do
    language = Factory.create(:language)
    assert !Factory.build(:language, :name => language.name).valid?
  end
  
  # A language has to have a name
  #
  should "not be valid with nil name" do
    language = Factory.create(:language)
    assert !Factory.build(:language, :name => nil).valid?
  end
  
  
  # Test valid language
  [
    'Deutsch',
    'English',
    'Klingon',
    '日本語',
    'Limba Română',
  ].each { |lang|
    should "allow #{lang.inspect} as language" do
      assert Factory.build( :language, :name => lang ).valid?
    end
  }
  
  # Test invalid language
  [
    '',
    nil,
  ].each { |lang|
    should "not allow #{lang.inspect} as language" do
      assert ! Factory.build( :language, :name => lang ).valid?
    end
  }
  
  
end
