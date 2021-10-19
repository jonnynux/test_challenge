class Product < ApplicationRecord
  validates :product_code, :name, :price, presence: true
  validates :product_code, :name, uniqueness: { case_sensitive: false }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate :product_code_format
  has_many :baskets, dependent: :destroy

  private

  def product_code_format
    return if product_code =~ /\A[A-Z]{2}\d*\z/

    errors.add(:product_code, "with invalid format, correct format is like GR1")
  end
end
