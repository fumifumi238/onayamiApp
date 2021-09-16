class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, invalid_words: true, length: { maximum: 1000 }
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships

  #  todo: validationの実行
  def save_tags(savemicropost_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - savemicropost_tags
    new_tags = savemicropost_tags - current_tags

    old_tags.each do |old_name|
      tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      micropost_tag = Tag.find_or_create_by(name: new_name)
      tags << micropost_tag if micropost_tag.save
    end
  end
end
