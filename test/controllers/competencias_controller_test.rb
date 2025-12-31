require "test_helper"

class CompetenciasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get competencias_index_url
    assert_response :success
  end

  test "should get show" do
    get competencias_show_url
    assert_response :success
  end
end
