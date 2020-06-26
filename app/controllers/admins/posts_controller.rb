class Admins::PostsController < ApplicationController
  before_action :post_information, only:[:edit,:update,:destroy]

  def index
    @posts_solution = Post.where(solution: false).order(created_at: "DESC").page(params[:page]).per(20)
    @posts = Post.all.order(created_at: "DESC").page(params[:page]).per(20)
  end

  def edit
    @comments = @post.comments.page(params[:page]).per(9)
    @comment = Comment.new
  end

  def update
    @post.update(posts_params) ? redirect_to(dmins_posts_path) : render(:edit)
  end

  def destroy
    @post.destroy ? redirect_to(admins_posts_path) : render(:index)
  end

  private
  def posts_params
    params.require(:post).permit(:title,:post_body,:post_image)
  end

  def post_information
    @post = Post.find(params[:id])
  end

end
