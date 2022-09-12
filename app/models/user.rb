class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: true
  validates :password, presence: true
  devise :database_authenticatable, :validatable

  has_many :posts, dependent: :destroy
end
