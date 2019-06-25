FactoryBot.define do
  factory :user do
    name {FFaker::Name.name}
    email {FFaker::Internet.email}
    password {FFaker::Lorem.characters 6}
    address {FFaker::Lorem.paragraph 1}
    phone {FFaker::PhoneNumber.phone_number}
    avatar {FFaker::Image.url size = "300x300", format = "png", bg_color = :random, text_color = :random, text = nil}
    trait :role do
      admin {Settings.role.admin}
    end
  end
end
