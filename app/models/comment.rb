class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 800 }
  validates :post_id, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
