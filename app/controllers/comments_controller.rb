class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @micropost = Micropost.find(params[:micropost_id])
    @comments = @micropost.comments
    # render json: @comment
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_to micropost_path(@micropost)
    else
      flash.now[:danger] = "コメントできませんでした"
      render 'microposts/show'
    end
  end


private
  def comment_params
    params.require(:comment).permit(:content,:micropost_id)
  end
end
