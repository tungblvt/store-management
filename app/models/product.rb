class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :comments

  enum status: %i(unavailable available)

  scope :order_by_column, ->(column){order(column)}
  scope :search, ->(keyword){where 'products.name LIKE ?', "%#{keyword}%"}
  scope :in_categories, ->(arr_cate_id){where category_id: arr_cate_id}
  scope :product_available, ->{where status: 1}

  PRODUCT_PARAMS = %i(category_id name description price image status).freeze

  mount_uploader :image, PictureUploader

  validates :name, presence: true, length: {maximum: Settings.validates.name.name_max}
  validates :category_id, presence: true
  validates :price, presence: true, format: {with: Settings.validates.number}
  validate :image_size

  delegate :store, to: :category, prefix: false
  delegate :name, to: :category, prefix: true

  private

  def image_size
    errors.add :image, t("store.validate_image_size") if image.size > Settings.validates.store.image_size.megabytes
  end
end
