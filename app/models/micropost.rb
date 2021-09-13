class Micropost < ApplicationRecord

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true,invalid_words: true,length: { maximum: 1000}
  has_many :comments, dependent: :destroy
  has_many :likes
end
