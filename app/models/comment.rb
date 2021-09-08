class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :content, presence: true, length: { maximum: 1000 }
  validate :content_cannot_contain_blacklist_words
  validate :content_cannot_contain_invalid_regex
end
