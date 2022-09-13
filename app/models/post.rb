class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
  scope :ordered, -> { order(created_at: :desc) }

  belongs_to :user
  has_many :comments, dependent: :destroy
end
