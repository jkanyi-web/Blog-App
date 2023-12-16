module Api
  module V1
    class CommentsController < ApplicationController
      def index
        post = User.find(params[:user_id]).posts.find(params[:post_id])
        comments = post.comments
        render json: comments
      end
    end
  end
end
