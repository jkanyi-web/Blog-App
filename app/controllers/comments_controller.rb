class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @user = User.find_by(id: params[:user_id])

    if @post.nil?
      render json: { error: 'Post not found' }, status: :not_found
    elsif @user.nil?
      render json: { error: 'User not found' }, status: :not_found
    else
      @comment = @post.comments.new(comment_params)
      @comment.user = @user

      if @comment.save
        render json: @comment, status: :created
      else
        render json: { error: 'Comment could not be created', details: @comment.errors }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully deleted!'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
