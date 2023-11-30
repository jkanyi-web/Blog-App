require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'after_save callback' do
    it 'updates the likes_counter of the post' do
      user = User.create(name: 'Test User', posts_counter: 0)
      post = Post.create(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0)
      Like.create(user:, post:)
      expect(post.reload.likes_counter).to eq(1)
    end
  end
end
