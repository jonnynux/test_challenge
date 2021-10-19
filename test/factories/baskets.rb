FactoryBot.define do
  factory :basket do
    product{ Product.last || create(:product)}
  end
end
