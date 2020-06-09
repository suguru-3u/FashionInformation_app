class Users::PostsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create
  end

  private
  def posts_params
    params.require(:post).permit(:title,:post_body,:post_image)
  end
end
