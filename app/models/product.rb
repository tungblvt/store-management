class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :comments

  scope :order_by_column, ->(column){order(column)}
  scope :search, ->(keyword){where 'products.name LIKE ?', "%#{keyword}%"}

  PRODUCT_PARAMS = %i(category_id name description price image).freeze
  mount_uploader :image, PictureUploader
  validates :name, presence: true, length: {maximum: Settings.validates.name.name_max}
  validate :image_size

  delegate :store, to: :category, prefix: false

  private

  def image_size
    errors.add :image, t("store.validate_image_size") if image.size > Settings.validates.store.image_size.megabytes
  end
end
