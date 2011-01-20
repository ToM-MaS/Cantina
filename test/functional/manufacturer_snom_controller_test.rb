require 'test_helper'

class ManufacturerSnomControllerTest < ActionController::TestCase
      
  context "show action" do
    should "render show template" do
      get :show, :id => ManufacturerSnom.first
      assert_template 'show'
    end
  end    
              
end
