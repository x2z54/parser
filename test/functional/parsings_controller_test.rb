require 'test_helper'

class ParsingsControllerTest < ActionController::TestCase
  setup do
    @parsing = parsings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parsings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parsing" do
    assert_difference('Parsing.count') do
      post :create, parsing: { Page: @parsing.Page, body: @parsing.body, link: @parsing.link, num: @parsing.num, title: @parsing.title }
    end

    assert_redirected_to parsing_path(assigns(:parsing))
  end

  test "should show parsing" do
    get :show, id: @parsing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parsing
    assert_response :success
  end

  test "should update parsing" do
    put :update, id: @parsing, parsing: { Page: @parsing.Page, body: @parsing.body, link: @parsing.link, num: @parsing.num, title: @parsing.title }
    assert_redirected_to parsing_path(assigns(:parsing))
  end

  test "should destroy parsing" do
    assert_difference('Parsing.count', -1) do
      delete :destroy, id: @parsing
    end

    assert_redirected_to parsings_path
  end
end
