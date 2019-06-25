FactoryBot.define do
  factory :order_detail do
    quantity {FFaker::Number.rand 10}
    price {FFaker::Random.rand 200000}
    total {FFaker::Random.rand 200000}
    shipped_date {FFaker::Time.date}
    trait :status do
      status {0}
    end
  end
end
