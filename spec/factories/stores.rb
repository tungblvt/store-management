FactoryBot.define do
  factory :store do
    name {FFaker::Lorem.characters 10}
    short_description {FFaker::Lorem.characters 30}
    description {FFaker::Lorem.paragraph 2}
    image {FFaker::Image.url size = "300x300", format = "png", bg_color = :random, text_color = :random, text = nil}
    address {FFaker::Lorem.paragraph 1}
    trait :status do
      status {1}
      is_lock {false}
    end
  end
end
