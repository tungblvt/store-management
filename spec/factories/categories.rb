FactoryBot.define do
  factory :category do
    name {FFaker::Lorem.characters 10}
    description {FFaker::Lorem.paragraph}
    is_deleted {false}
  end
end
