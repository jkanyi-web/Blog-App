require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'after_save callback' do
    it 'updates the comments_counter of the post' do
      user = User.create(name: 'Test User', posts_counter: 0)
      post = Post.create(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0)
      Comment.create(user:, post:)
      expect(post.reload.comments_counter).to eq(1)
    end
  end
end
