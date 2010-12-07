require 'test_helper'

class TxtsControllerTest < ActionController::TestCase
  setup do
    @txt = txts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:txts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create txt" do
    assert_difference('Txt.count') do
      post :create, :txt => @txt.attributes
    end

    assert_redirected_to txt_path(assigns(:txt))
  end

  test "should show txt" do
    get :show, :id => @txt.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @txt.to_param
    assert_response :success
  end

  test "should update txt" do
    put :update, :id => @txt.to_param, :txt => @txt.attributes
    assert_redirected_to txt_path(assigns(:txt))
  end

  test "should destroy txt" do
    assert_difference('Txt.count', -1) do
      delete :destroy, :id => @txt.to_param
    end

    assert_redirected_to txts_path
  end
end
