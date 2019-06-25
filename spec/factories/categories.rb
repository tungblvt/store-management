FactoryBot.define do
  factory :category do
    name {FFaker::Lorem.characters 10}
    description {FFaker::Lorem.characters 30}
  end
end
