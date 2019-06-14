cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
password = BCrypt::Password.create "foobar", cost: cost

User.create! name:  "Example User",
             email: "example@railstutorial.org",
             address: "ha noi",
             phone: "1234567",
             password_digest: password,
             remember_digest: password,
             role: "admin"
