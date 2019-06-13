class Store < ApplicationRecord
  belongs_to :user
  has_many :categories
  has_many :orders
end
