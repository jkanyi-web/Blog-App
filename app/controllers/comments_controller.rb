class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to user_post_path(@post.author, @post)
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to user_posts_path(@post.author), notice: 'Comment was successfully deleted!'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
