class Api::MicropostsController < ApplicationController
  def index
    # idが一意ではない
    @microposts = Micropost.left_joins(:likes,:user).select('users.name as user_name ,microposts.*, count(likes.id) as likes_count').group(:id)
    checked_anonymous?(@microposts)
  end

private
  def checked_anonymous?(microposts)
    microposts.each do |micropost|
        micropost.user_name = "匿名希望" if micropost.anonymous?
    end
  end
end
