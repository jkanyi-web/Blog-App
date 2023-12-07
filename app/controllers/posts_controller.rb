class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.page(params[:page]).per(2)
    @posts_count = @posts.count
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments_count = @post.comments.count
    @likes_count = @post.likes.count
  end
end
