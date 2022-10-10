class Post < ApplicationRecord
  include ActionText::Attachable
  validates :title, presence: true
  validates_presence_of :rich_content
  validates :user, presence: true
  validates :publish_date, presence: true
  validates :post_tags, length: { maximum: 5, too_long: "5 tags is the maximum allowed" }
  # validates :tags, length: { maximum: 5 }
  scope :containing, -> (query) { where(arel_table[:title].matches("%#{query}%")) }
  scope :ordered, -> { order(created_at: :desc) }
  scope :published, -> { where('publish_date <= ?', Date.current).order(publish_date: :desc)}
  scope :tagged_with, ->(title) { joins(:tags).where(tags: {title: title}) }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_rich_text :rich_content 
  attr_accessor :extracted_tags

  def extracted_tags=(tag_titles)
    tag_titles.each do |t|
      tags << Tag.where(title: t).first_or_create
      # binding.pry
    end
  end

  def preview
    rich_content.to_plain_text.truncate_words(5, omission: "... (Read More)")
  end

  def has_image?
    rich_content.embeds.count > 0
  end 
end

