module Api
  module V1
    class CommentsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_user

      def index
        post = User.find(params[:user_id]).posts.find(params[:post_id])
        comments = post.comments
        render json: comments
      end

      def create
        post = User.find(params[:user_id]).posts.find(params[:post_id])
        comment = post.comments.new(comment_params)
        comment.user = @current_user

        if comment.save
          render json: comment
        else
          render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end
end
