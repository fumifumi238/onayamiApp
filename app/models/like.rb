class Like < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  validates :micropost_id, uniqueness: { scope: :user_id }
  scope :filter_by_post, ->(micropost_id) { where(micropost_id: micropost_id) if micropost_id }
end
