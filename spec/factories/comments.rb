FactoryBot.define do
  factory :comment do
    content {FFaker::Lorem.paragraph 1}
    subtotal {FFaker::Random.rand 10}
  end
end
