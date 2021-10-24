require "test_helper"

class BasketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basket = create(:basket)
  end

  test "should get index" do
    get baskets_url
    assert_response :success
  end

  test "should get new" do
    get new_basket_url
    assert_response :success
  end

  test "should create basket" do
    assert_difference('Basket.count') do
      post baskets_url, params: { basket: { product_id: @basket.product_id } }
    end

    assert_redirected_to basket_url(Basket.last)
  end

  test "should show basket" do
    get basket_url(@basket)
    assert_response :success
  end

  test "should get edit" do
    get edit_basket_url(@basket)
    assert_response :success
  end

  test "should update basket" do
    patch basket_url(@basket), params: { basket: { product_id: @basket.product_id } }
    assert_redirected_to basket_url(@basket)
  end

  test "should destroy basket" do
    assert_difference('Basket.count', -1) do
      delete basket_url(@basket)
    end

    assert_redirected_to baskets_url
  end

  test "should checkout basket" do
    get baskets_url
    assert_difference('Basket.count', -1) do
      get checkout_baskets_url(@basket)
    end

    assert_redirected_to baskets_url
  end
end
