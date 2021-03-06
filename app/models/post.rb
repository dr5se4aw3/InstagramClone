class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user
  validates :image, presence: true
  validates :content, length: { in: 1..140 }
end
