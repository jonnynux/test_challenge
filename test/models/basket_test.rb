require "test_helper"
class BasketTest < ActiveSupport::TestCase
  setup do
    @gr = create(:product, product_code: 'GR1', name: 'Green Tea', price: '3.11')
    @sr = create(:product, product_code: 'SR1', name: 'Strawberries', price: '5.00')
    @cf = create(:product, product_code: 'CF1', name: 'Coffe', price: '11.23')
  end

  test "should give the correct total price for a product whithout discount" do
    price = 1
    n = [1, 10, 100]
    product = create(:product, price: price)
    n.each do |counts|
      Basket.destroy_all
      create_list(:basket, counts, product: product)
      assert_equal price * counts, Basket.total
      assert_equal price * counts, Basket.total_discounted
    end
  end

  test 'should give the correct total price from 1 to 3 elements of the same product' do
    # one element
    create(:basket, product: @gr)
    assert_equal @gr.price, Basket.total
    assert_equal @gr.price, Basket.total_discounted

    Basket.destroy_all
    create(:basket, product: @gr)
    assert_equal @gr.price, Basket.total
    assert_equal @gr.price, Basket.total_discounted

    Basket.destroy_all
    create(:basket, product: @gr)
    assert_equal @gr.price, Basket.total
    assert_equal @gr.price, Basket.total_discounted

    # two elements
    n = 2
    Basket.destroy_all
    create_list(:basket, n, product: @gr)
    assert_equal @gr.price * n, Basket.total
    assert_equal @gr.price, Basket.total_discounted

    Basket.destroy_all
    create_list(:basket, n, product: @sr)
    assert_equal @sr.price * n, Basket.total
    assert_equal @sr.price * n, Basket.total_discounted

    Basket.destroy_all
    create_list(:basket, n, product: @cf)
    assert_equal @cf.price * n, Basket.total
    assert_equal @cf.price * n, Basket.total_discounted

    # three elements
    n = 3
    Basket.destroy_all
    create_list(:basket, n, product: @gr)
    assert_equal @gr.price * n, Basket.total
    assert_equal @gr.price * 2, Basket.total_discounted

    Basket.destroy_all
    create_list(:basket, n, product: @sr)
    assert_equal @sr.price * n, Basket.total
    assert_equal 4.5 * n, Basket.total_discounted

    Basket.destroy_all
    create_list(:basket, n, product: @cf)
    assert_equal @cf.price * n, Basket.total
    assert_equal (@cf.price * n * 2 / 3).floor(2), Basket.total_discounted
  end

  test "should give the correct total price of mixed basket elements" do
    create(:basket, product: @sr)
    create(:basket, product: @sr)
    create(:basket, product: @gr)
    create(:basket, product: @sr)
    assert_equal @sr.price * 3 + @gr.price, Basket.total
    assert_equal 16.61, Basket.total_discounted

    Basket.destroy_all
    create(:basket, product: @sr)
    create(:basket, product: @sr)
    create(:basket, product: @gr)
    create(:basket, product: @sr)
    assert_equal @sr.price * 3 + @gr.price, Basket.total
    assert_equal 16.61, Basket.total_discounted
  end
end
