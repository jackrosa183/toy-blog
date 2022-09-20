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

end
