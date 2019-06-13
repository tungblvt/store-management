class User < ApplicationRecord
  has_many :stores
  has_many :comments
  has_many :orders
end
