class Post < ApplicationRecord
  self.per_page = 3
  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
  scope :ordered, -> { order(created_at: :desc) }

  belongs_to :user
end
