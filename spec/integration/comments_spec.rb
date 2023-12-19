require 'swagger_helper'

describe 'Comments API' do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves comments' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer
      parameter name: 'Authorization', in: :header, type: :string

      response '200', 'comments retrieved' do
        let(:user) { User.create!(email: 'jkanyi757@gmail.com', password: 'victor') }
        let(:blog_post) { user.posts.create!(title: 'Test Post', comments_counter: 0, likes_counter: 0) }
        let(:user_id) { user.id }
        let(:post_id) { blog_post.id }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(id: user.id)}" }
        run_test!
      end
    end

    post 'Creates a comment' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer
      parameter name: :comment_params, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }
      parameter name: 'Authorization', in: :header, type: :string

      response '200', 'comment created' do
        let(:user) { User.create!(email: 'jkanyi757@gmail.com', password: 'victor') }
        let(:blog_post) { user.posts.create!(title: 'Test Post', comments_counter: 0, likes_counter: 0) }
        let(:user_id) { user.id }
        let(:post_id) { blog_post.id }
        let(:comment_params) { { text: 'A comment' } }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(id: user.id)}" }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { User.create!(email: 'jkanyi757@gmail.com', password: 'victor') }
        let(:blog_post) { user.posts.create!(title: 'Test Post', comments_counter: 0, likes_counter: 0) }
        let(:user_id) { user.id }
        let(:post_id) { blog_post.id }
        let(:comment_params) { { text: '' } }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(id: user.id)}" }
        run_test!
      end
    end
  end
end
