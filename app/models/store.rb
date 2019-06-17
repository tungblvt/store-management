class Store < ApplicationRecord
  belongs_to :user
  has_many :categories
  has_many :orders

  scope :order_by_column, ->(column){order(column)}

  STORE_PARAMS = %i(name short_description description image).freeze

  mount_uploader :image, PictureUploader
  validates :user_id, presence: true
  validates :short_description, presence: true,
    length: {maximum: Settings.validates.store.short_description_max}
  validate :image_size

  private

  def image_size
    errors.add :image, t("store.validate_image_size") if image.size > Settings.validates.store.image_size.megabytes
  end
end
