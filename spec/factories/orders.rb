FactoryBot.define do
  factory :order do
    address {FFaker::Lorem.paragraph 1}
    subtotal {FFaker::Random.rand 200000}
    shipped_date {FFaker::Time.date}
    trait :status do
      status {0}
    end
  end
end
