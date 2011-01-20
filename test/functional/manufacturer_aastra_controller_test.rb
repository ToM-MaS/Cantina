require 'test_helper'

class ManufacturerAastraControllerTest < ActionController::TestCase
      
  context "show action" do
    should "render show template" do
      get :show, :id => ManufacturerAastra.first
      assert_template 'show'
    end
  end    
              
end
