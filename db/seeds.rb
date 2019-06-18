cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
password = BCrypt::Password.create "foobar", cost: cost

url_image = FFaker::Image.url size = "60x60", format = "png",
                              bg_color = :random,
                              text_color = :random, text = nil

User.create! name:  "Admin User",
             email: "admin@gmail.com",
             avatar: url_image,
             address: FFaker::Lorem.paragraph(1),
             phone: "1234567",
             password_digest: password,
             remember_digest: password,
             role: "ADMIN"

User.create! name:  "Manager User",
             email: "manager@gmail.com",
             avatar: url_image,
             address: FFaker::Lorem.paragraph(2),
             phone: "1234567",
             password_digest: password,
             remember_digest: password,
             role: "MANAGER"

99.times do |n|
  url_image = FFaker::Image.url size = "60x60", format = "png",
                                bg_color = :random,
                                text_color = :random, text = nil
  name  = FFaker::Name.name
  email = "test-#{n+1}@project1.org"
  User.create! name:  name,
               avatar: url_image,
               email: email,
               address: FFaker::Lorem.paragraph(1),
               phone: "1234567",
               password_digest: password,
               remember_digest: password,
               role: "MEMBER"
end

Store.create! name: "store name",
              address: "Address",
              short_description: "short description",
              description: "description",
              image: "image",
              user_id: 1

Category.create! name: "Category",
                 description: "description",
                 store_id: 1

Category.create! name: "Category1",
                 description: "description",
                 store_id: 1
