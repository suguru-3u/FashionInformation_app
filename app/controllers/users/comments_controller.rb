class Users::CommentsController < ApplicationController

  # コメント生成
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      # flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      # flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  # コメント削除
  def destroy
    @comment = Comment.find_by(post_id: params[:post_id], user_id: current_user.id)
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
