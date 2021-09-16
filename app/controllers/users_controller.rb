class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: %i[index destroy]

  def index
    @users = User.all
  end

  def show
    @user = current_user.admin ? User.find(params[:id]) : current_user
    @microposts = @user.microposts
    @likes = @user.liked_posts
  end

  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
