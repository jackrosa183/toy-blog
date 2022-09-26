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
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  attr_accessor :tag_titles
  attr_accessor :extracted_tags

  def extracted_tags=(tag_titles)
    tag_titles.each do |t|
      tags << Tag.where(title: t).first_or_create
      # binding.pry
    end
  end
end

