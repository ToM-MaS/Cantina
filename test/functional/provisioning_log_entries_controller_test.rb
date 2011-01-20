require 'test_helper'

class ProvisioningLogEntriesControllerTest < ActionController::TestCase
  setup do
    @provisioning_log_entry = Factory.create(:provisioning_log_entry)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:provisioning_log_entries)
  end

  test "should show provisioning_log_entry" do
    get :show, :id => @provisioning_log_entry.to_param
    assert_response :success
  end
end
