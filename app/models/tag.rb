class Tag < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :post_tags
  has_many :posts, through: :post_tags
  scope :containing, -> (query) { where(arel_table[:title].matches("%#{query}%")) }
  before_save :lower_title

  def lower_title
    self.title.downcase!
  end
end
