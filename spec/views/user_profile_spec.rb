# spec/system/user_profile_spec.rb

require 'rails_helper'

RSpec.describe 'User Profile Page', type: :system do
  let!(:user) { create(:user) }

  before do
    # Create posts for the user
    create_list(:post, 5, author: user)
  end

  it 'displays user profile details with latest 3 posts' do
    visit user_path(user)

    expect(page).to have_css('img.user-image')
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.posts.count}")
    expect(page).to have_content(user.bio)

    user.recent_posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'displays a link to all the user\'s post page' do
    visit user_path(user)

    expect(page).to have_link('See All Posts', href: user_posts_path(user))

    click_link('See All Posts')
    expect(page).to have_current_path(user_posts_path(user))
  end

  it 'redirect to the post details page' do
    visit user_path(user)

    first('.user-post').click
    expect(page).to have_current_path(user_post_path(user, user.posts.first))
  end
end
