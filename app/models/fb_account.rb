class FbAccount < ApplicationRecord
  belongs_to :user

  validates :email, presence: true
  validates :uid, presence: true
  validates :token, presence: true
  validates :name, presence: true
  
end
