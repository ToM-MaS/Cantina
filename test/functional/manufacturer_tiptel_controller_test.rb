require 'test_helper'

class ManufacturerTiptelControllerTest < ActionController::TestCase
      
  context "show action" do
    should "render show template" do
      get :show, :id => ManufacturerTiptel.first
      assert_template 'show'
    end
  end    
              
end
