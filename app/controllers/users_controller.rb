class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts_count = @user.posts.count
    @recent_posts = @user.recent_posts
  end
end
