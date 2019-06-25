FactoryBot.define do
  factory :comment do
    content {FFaker::Lorem.paragraph 1}
    rate {FFaker::Random.rand 5}
  end
end
