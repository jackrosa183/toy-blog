class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
  validates :publish_date, presence: true
  scope :ordered, -> { order(created_at: :desc) }
  scope :published, -> { where('publish_date <= ?', Date.current).order(publish_date: :desc)}
  scope :tagged_with, ->(title) { joins(:tags).where(tags: {title: title}) }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  
end

