class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'You liked this post.'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Unable to like this post.'
    end
  end
end
