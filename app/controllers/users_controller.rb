class UsersController < ApplicationController
before_action :authenticate_user!
  def show
    @user = current_user
    @microposts = @user.microposts
    @likes = @user.liked_posts
  end
end
