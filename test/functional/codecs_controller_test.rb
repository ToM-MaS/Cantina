require 'test_helper'

class CodecsControllerTest < ActionController::TestCase
  setup do
    @codec = Factory.create(:codec)  
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:codecs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create codec" do
    assert_difference('Codec.count') do
      post :create, :codec => Factory.attributes_for(:codec)
    end

    assert_redirected_to codec_path(assigns(:codec))
  end

  test "should show codec" do
    get :show, :id => @codec.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @codec.to_param
    assert_response :success
  end

  test "should update codec" do
    put :update, :id => @codec.to_param, :codec => @codec.attributes
    assert_redirected_to codec_path(assigns(:codec))
  end

  test "should destroy codec" do
    assert_difference('Codec.count', -1) do
      delete :destroy, :id => @codec.to_param
    end

    assert_redirected_to codecs_path
  end
end
