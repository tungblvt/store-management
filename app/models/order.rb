class Order < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_many :order_details

  scope :order_by_column, ->(column){order column}

  enum status: %i(pending approved shipped cancel)

  ORDER_PARAMS = %i(store_id user_id status address shipped_date).freeze

  delegate :name, to: :user, prefix: true
  delegate :name, to: :store, prefix: true
end
