class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :ordered, -> { order(created_at: :desc) }
end
