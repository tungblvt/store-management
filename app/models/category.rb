class Category < ApplicationRecord
  belongs_to :store
  has_many :products

  CATEGORY_PARAMS = %i(name description store_id).freeze
end
