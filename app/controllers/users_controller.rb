class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts_count = @user.posts.count
    @recent_posts = @user.recent_posts
  end

  def complete_profile
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_path, notice: 'Profile was successfully updated.'
    else
      puts @user.errors.full_messages
      render :complete_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :posts_counter, :photo, :bio)
  end
end
