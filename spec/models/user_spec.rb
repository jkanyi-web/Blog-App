require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key(:author_id).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).is_greater_than_or_equal_to(0) }
  end

  describe '#recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'Test User', posts_counter: 0)
      4.times do
        Post.create(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0)
      end
      expect(user.recent_posts.length).to eq(3)
      expect(user.recent_posts).to eq(Post.order(created_at: :desc).limit(3))
    end
  end
end
