require "test_helper"

class Searches::ProductCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get searches_product_categories_show_url
    assert_response :success
  end
end
