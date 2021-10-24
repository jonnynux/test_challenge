require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = create(:product)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    product = build(:product)
    assert_difference('Product.count') do
      post products_url, params: { product: { name: product.name, price: product.price,
        product_code: product.product_code } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { name: @product.name, price: @product.price,
      product_code: @product.product_code } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "should add to basket" do
    get products_url
    3.times do
      assert_difference('Basket.count') do
        get add_to_basket_product_path(@product)
      end

      assert_redirected_to products_url
    end
  end
end
