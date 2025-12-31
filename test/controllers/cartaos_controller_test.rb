require "test_helper"

class CartaosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cartaos_index_url
    assert_response :success
  end

  test "should get show" do
    get cartaos_show_url
    assert_response :success
  end

  test "should get new" do
    get cartaos_new_url
    assert_response :success
  end

  test "should get create" do
    get cartaos_create_url
    assert_response :success
  end
end
