FactoryBot.define do
  factory :order do
    address {FFaker::Lorem.paragraph 1}
    description {FFaker::Lorem.paragraph 2}
    image {FFaker::Image.url size = "300x300", format = "png", bg_color = :random, text_color = :random, text = nil}
    subtotal {FFaker::Random.rand 200000}
    shipped_date {FFaker::Time.date}
    trait :status do
      status {0}
    end
  end
end
