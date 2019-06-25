FactoryBot.define do
  factory :product do
    name {FFaker::Lorem.characters 10}
    description {FFaker::Lorem.paragraph 2}
    image {FFaker::Image.url size = "300x300", format = "png", bg_color = :random, text_color = :random, text = nil}
    price {FFaker::Random.rand 200000}
    trait :status do
      status {1}
      is_deleted {false}
    end
  end
end
