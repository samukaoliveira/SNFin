require "test_helper"

class LancamentosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lancamentos_index_url
    assert_response :success
  end

  test "should get new" do
    get lancamentos_new_url
    assert_response :success
  end

  test "should get create" do
    get lancamentos_create_url
    assert_response :success
  end

  test "should get edit" do
    get lancamentos_edit_url
    assert_response :success
  end

  test "should get update" do
    get lancamentos_update_url
    assert_response :success
  end

  test "should get destroy" do
    get lancamentos_destroy_url
    assert_response :success
  end
end
