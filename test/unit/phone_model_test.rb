require 'test_helper'

class PhoneModelTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory.build(:phone_model).valid?
  end
  
  # nil is not a valid value
  #
  [
    'max_number_of_sip_accounts',
    'number_of_keys',
    'max_number_of_phone_book_entries',
    'manufacturer_id'
  ].each do |field_name|
    should "not be ok to set #{field_name} to nil" do
      assert !Factory.build(:phone_model, field_name.to_sym => nil).valid?
    end
  end

  # -1 is not a valid value
  #
  [
    'max_number_of_sip_accounts',
    'number_of_keys',
    'max_number_of_phone_book_entries',
    'manufacturer_id'
  ].each do |field_name|
    should "not be ok to set #{field_name} to -1" do
      assert !Factory.build(:phone_model, field_name.to_sym => -1).valid?
    end
  end
  
  # phone_model has to have a manufacturer
  #
  should "have a valid manufacturer" do
    phone_model = Factory.build(:phone_model)
    Manufacturer.where(:id => phone_model.manufacturer_id).destroy_all
    assert !phone_model.valid?
  end

  
end
