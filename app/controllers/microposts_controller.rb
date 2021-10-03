class MicropostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show tagname]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @microposts = Micropost.left_joins(:likes,:user).select('users.name as user_name ,microposts.*, count(likes.id) as likes_count').group(:id)
    checked_anonymous?(@microposts)
    # render json: @microposts, status: 422
  end

  def new
    @micropost = current_user.microposts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    tag_list = params[:micropost][:tag_ids].split(',').uniq
    if @micropost.save && @micropost.save_tags(tag_list)
      flash[:success] = '投稿が完了しました'
      redirect_to root_path
    else
      flash.now[:danger] = '投稿に失敗しました'
      render 'new'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments
    @comment = Comment.new
    #  debugger
  end

  def edit
    @micropost = Micropost.find(params[:id])
    @tag_list = @micropost.tags.pluck(:name).join(',')
  end

  def update
    @micropost = Micropost.find(params[:id])
    tag_list = params[:micropost][:tag_ids].split(',').uniq
    if @micropost.update(micropost_params) && @micropost.save_tags(tag_list)
      flash[:success] = '投稿が編集されました'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @user = @micropost.user
    @micropost.destroy
    flash[:success] = '投稿が削除されました'
    redirect_to show_users_path(@user)
  end

  def tagname
    @tag = Tag.find_by(name: params[:tagname])
    @microposts = @tag.microposts
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :anonymous)
    end

    def correct_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_path if @micropost.user_id != current_user.id && !current_user.admin?
    end

    def checked_anonymous?(microposts)
        microposts.each do |micropost|
        micropost.user_name = "匿名希望" if micropost.anonymous?
    end
  end
end
