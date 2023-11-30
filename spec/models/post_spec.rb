require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).is_greater_than_or_equal_to(0) }
  end

  describe '#recent_comments' do
    it 'returns the 5 most recent comments' do
      user = User.create(name: 'Test User', posts_counter: 0)
      post = Post.create(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0)
      6.times do
        Comment.create(user:, post:)
      end
      expect(post.recent_comments.length).to eq(5)
      expect(post.recent_comments).to eq(Comment.order(created_at: :desc).limit(5))
    end
  end

  describe 'after_save callback' do
    it 'updates the posts_counter of the author' do
      user = User.create(name: 'Test User', posts_counter: 0)
      Post.create(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0)
      expect(user.reload.posts_counter).to eq(1)
    end
  end
end
