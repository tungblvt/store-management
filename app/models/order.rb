class Order < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_many :order_details

  scope :order_by_column, ->(column){order column}

  enum status: %i(pending approved shipped cancel)

  delegate :name, to: :user, prefix: true
end
