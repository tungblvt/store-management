class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_save :set_total
  before_save :set_price

  scope :order_by_column, ->(column){order column}

  ORDER_DETAIL_PARAMS = %i(product_id quantity).freeze

  def price
    if persisted?
      self[:price]
    else
      product.price
    end
  end

  def total
    price.to_i * quantity
  end

  private

  def set_price
    self[:price] = price
  end

  def set_total
    self[:total] = total.to_i * quantity
  end
end
