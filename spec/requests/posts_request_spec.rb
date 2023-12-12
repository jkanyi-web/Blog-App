require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      user = User.create!(name: 'Test User', posts_counter: 0)
      post = user.posts.create!(
        title: 'Test Post',
        text: 'This is a placeholder for a single post.',
        comments_counter: 0,
        likes_counter: 0
      )
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
      expect(response.body).to include(post.text)
    end
  end
end
