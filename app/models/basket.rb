class Basket < ApplicationRecord
  belongs_to :product

  def self.total
    Basket.all.map{ |b| b.product.price }.sum.floor(2)
  end

  def self.total_discounted
    groups = Basket.all.map(&:product_id).tally
    groups.map do |product_id, n|
      product = Product.find(product_id)
      p = product.price
      case product.product_code
      when 'GR1'
        n / 2 * p + n % 2 * p
      when 'SR1'
        n > 2 ? n * 4.50 : n * p
      when 'CF1'
        n > 2 ? n * p * 2 / 3 : n * p
      else
        n * p
      end
    end.sum.floor(2)
  end
end
