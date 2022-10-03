class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: true
  validates :password, presence: true
  devise :database_authenticatable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_one :twitter_account, dependent: :destroy
  has_one :fb_account, dependent: :destroy
  has_one :linkedin_account, dependent: :destroy

  has_one :avatar
  # validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
  #                   file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }
end

