class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :comments

  PRODUCT_PARAMS = %i(category_id name description price image).freeze
  mount_uploader :image, PictureUploader
  validates :name, presence: true, length: {maximum: Settings.validates.name.name_max}
  validate :image_size

  private

  def image_size
    errors.add :image, t("store.validate_image_size") if image.size > Settings.validates.store.image_size.megabytes
  end
end
