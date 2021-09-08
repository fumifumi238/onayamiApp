class MicropostsController < ApplicationController
before_action :authenticate_user!,except: [:index,:show]
  def index
    @microposts = Micropost.all
    # render json: @microposts, status: 422
  end

  def new
    @micropost = current_user.microposts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿が完了しました"
      redirect_to microposts_path
    else
      flash.now[:danger] = "投稿に失敗しました"
      render 'new'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments
    @comment = Comment.new
     debugger
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update(micropost_params)
      flash[:success] = "投稿が編集されました"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    flash[:success] = "投稿が削除されました"
    redirect_to root_path
  end


private

  def micropost_params
    params.require(:micropost).permit(:content,:anonymous)
  end

end
