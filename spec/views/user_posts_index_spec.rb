require 'rails_helper'

RSpec.describe 'User Profile and Posts Page', type: :system do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 10, author: user, text: 'This is the text of the post.') }

  before do
    visit user_posts_path(user)
  end

  it 'displays user profile and posts details and pagination' do
    expect(page).to have_css('img.user-image')
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of Posts: #{user.posts.count}")

    posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.body.truncate(50))
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes.count}")
      expect(page).to have_link(post.title, href: post_path(post))
    end

    expect(page).to have_selector('.pagination')
  end

  it 'redirect to the post details page' do
    visit user_path(user)

    first('.user-post').click
    expect(page).to have_current_path(user_post_path(user, user.posts.first))
  end
end
