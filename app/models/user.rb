class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :stores
  has_many :comments
  has_many :orders

  enum role: %i(ADMIN MANAGER MEMBER)

  scope :order_by_column, ->(column){order(column)}

  VALID_EMAIL_REGEX = Settings.validates.email.regex
  USER_PARAMS = %i(name email password password_confirmation address phone role avatar).freeze

  mount_uploader :avatar, PictureUploader
  validates :name, presence: true, length: {maximum: Settings.validates.name.name_max}
  validates :email, presence: true,
    length: { maximum: Settings.validates.email.length },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true,
    length: { minimum: Settings.validates.password.length.minimum },
    allow_nil: true

  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = self.send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update remember_token: nil
  end

  def is_admin?
    User.roles[role] == Settings.role.admin.to_i
  end

  def is_manager?
    User.roles[role] == Settings.role.manager.to_i
  end

  def is_member?
    User.roles[role] == Settings.role.member.to_i
  end

  def image_size
    errors.add :avatar, t("user.validate_image_size") if avatar.size > Settings.validates.user.image_size.megabytes
  end
end
