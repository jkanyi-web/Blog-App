module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user

      def index
        @user = User.find(params[:user_id])
        @posts = @user.posts
        render json: @posts
      end
    end
  end
end
