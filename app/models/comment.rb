class Comment < ApplicationRecord
  belongs_to :user, presence: true
  belongs_to :micropost, presence: true
  validates :content, presence: true, invalid_words: true, length: { maximum: 1000 }
end
