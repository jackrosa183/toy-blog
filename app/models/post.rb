class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
  validates :publish_date, presence: true
  scope :ordered, -> { order(created_at: :desc) }
  scope :published, -> { where('publish_date <= ?', Date.current).order(publish_date: :desc)}

  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.ordered_meth
    order(created_at: :desc)
  end
end

