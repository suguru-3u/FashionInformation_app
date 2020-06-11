class Users::PostsController < ApplicationController
    before_action :post_get_id, only:[:show,:edit,:update,:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(posts_params)
    @post.save ? redirect_to(users_posts_path) : render(:new)
  end

  def index
    @posts = Post.all
  end

  def show
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def edit
  end

  def update
    @post.update(posts_params) ? redirect_to(users_posts_path) : render(:edit)
  end

  def destroy
    @post.destroy ? redirect_to(users_posts_path) : render(:index)
  end

  def search
    @posts = Post.search(params[:search])
  end

  private
  def posts_params
    params.require(:post).permit(:title,:post_body,:post_image)
  end

  def post_get_id
    @post = Post.find(params[:id])
  end

end
