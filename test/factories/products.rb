FactoryBot.define do
  factory :product do
    sequence(:product_code){ |n| "AA#{n}" }
    sequence(:name){ |n| "Name#{n}" }
  end
end
