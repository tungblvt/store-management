class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  scope :order_by_column, ->(column){order column}
end
