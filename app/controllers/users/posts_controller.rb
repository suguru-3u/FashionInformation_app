class Users::PostsController < ApplicationController
    before_action :post_get_id, only:[:show,:edit,:update,:destroy]

  def index
    @post = Post.new
    @posts = Post.where(solution: false).order(created_at: "DESC").page(params[:page]).per(9)
    @users = User.order(answer_point: "DESC").limit(3)
  end

  def create
    @posts = Post.all
    @post = current_user.posts.new(posts_params)
    if @post.save
      respond_to do |format|
        format.html { redirect_to(users_posts_path) }
        format.json
      end
    else
      render(:index)
    end
  end


  def show
    @comments = @post.comments.page(params[:page]).per(9)
    @comment = Comment.new
  end

  def edit
  end

  def update
    if params[:solution]
      @post.solution = params[:solution]
      @post.update ? redirect_to(users_posts_path) : render(:show)
    end
    @post.update(posts_params) ? redirect_to(users_posts_path) : render(:edit)
  end

  def destroy
    @post.destroy ? redirect_to(users_posts_path) : render(:index)
  end

  def search
   if params[:name]
     if params[:name].empty?
     @posts = Post.none
     else
     @posts = Post.where('title LIKE(?)', "%#{params[:name]}%")
     end
   else
     @posts = Post.all
   end

   respond_to do |format|
    format.html
    format.json
   end

  end

  private
  def posts_params
    params.require(:post).permit(:title,:post_body,:post_image,:solution)
  end

  def post_get_id
    @post = Post.find(params[:id])
  end

end
