class PostsController < ApplicationController
  before_action :set_user

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes({ comments: :user }, :likes).page(params[:page]).per(2)
    @posts_count = @posts.count
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments_count = @post.comments.count
    @likes_count = @post.likes.count
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    authorize! :destroy, @post
    @post.destroy
    redirect_to user_posts_path(@user), notice: 'Post was successfully deleted!'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
