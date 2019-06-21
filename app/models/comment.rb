class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :store

  COMMENT_PARAMS = %i(content rate store_id)

  validates :content, presence: true
end
