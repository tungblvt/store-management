class Category < ApplicationRecord
  belongs_to :store
  has_many :products

  scope :order_by_column, ->(column){order(column)}
  scope :select_id_and_name, ->{select :id, :name}
  scope :deleted, ->{where is_deleted: false}

  CATEGORY_PARAMS = %i(name description store_id).freeze

  delegate :name, to: :store, prefix: true
end
