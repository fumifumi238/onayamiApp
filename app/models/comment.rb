class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :content, presence: true, invalid_words: true, length: { maximum: 1000 }
end
