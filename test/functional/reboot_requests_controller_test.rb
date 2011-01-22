require 'test_helper'

class RebootRequestsControllerTest < ActionController::TestCase
  setup do
    @reboot_request = Factory.create(:reboot_request)
    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reboot_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reboot_request" do
    assert_difference('RebootRequest.count') do
      post :create, :reboot_request => @reboot_request.attributes
    end

    assert_redirected_to reboot_request_path(assigns(:reboot_request))
  end

  test "should show reboot_request" do
    get :show, :id => @reboot_request.to_param
    assert_response :success
  end

end
