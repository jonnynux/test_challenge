require "test_helper"

class ProductTest < ActiveSupport::TestCase
  setup do
    @product = create(:product)
  end

  test "should not create product with already present code" do
    product = build(:product, product_code: @product.product_code)
    assert_not product.save
    assert_equal ({ product_code: ["has already been taken"] }), product.errors.messages
  end

  test "should not create product with already present name" do
    product = build(:product, name: @product.name)
    assert_not product.save
    assert_equal ({ name: ["has already been taken"] }), product.errors.messages
  end

  test "should not create product with negative price" do
    product = build(:product, price: '-5')
    assert_not product.save
    assert_equal ({ price: ["must be greater than or equal to 0"] }), product.errors.messages
  end
end
