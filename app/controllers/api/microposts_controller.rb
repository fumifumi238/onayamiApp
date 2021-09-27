class Api::MicropostsController < ApplicationController
  def index
    # idが一意ではない
    @microposts = Micropost.joins(:user).select("microposts.*,users.*")
    checked_anonymous?(@microposts)
  end

private
  def checked_anonymous?(microposts)
    microposts.each do |micropost|
        micropost.name = "匿名希望" if micropost.anonymous?
    end
  end
end
