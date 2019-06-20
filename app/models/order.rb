class Order < ApplicationRecord
  belongs_to :user
  belongs_to :store

  has_many :order_details
  has_many :products, through: :order_details

  scope :order_by_column, ->(column){order column}
  scope :group_by_column, ->(column){group column}
  scope :joins_order_details_products, ->(order_id){joins(:order_details, :products).where id: order_id}
  scope :select_order_detail, ->{select "orders.*, order_details.quantity as quantity, order_details.price as price, products.id as product_id, products.name as product_name"}
  scope :IN_stores, ->(arr_store_id){where store_id: arr_store_id}

  enum status: %i(pending approved shipped cancel)

  ORDER_PARAMS = %i(store_id user_id status address shipped_date).freeze

  delegate :name, to: :user, prefix: true
  delegate :name, to: :store, prefix: true

end
