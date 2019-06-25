FactoryBot.define do
  factory :order_detail do
    quantity {FFaker::Random.rand 10}
    price {FFaker::Random.rand 200000}
    total {FFaker::Random.rand 200000}
  end
end
