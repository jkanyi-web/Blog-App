require 'rails_helper'

RSpec.describe 'Post Details Page', type: :system do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, author: user) }

  before do
    visit post_path(post)
  end

  it 'displays post details, comments nd like button' do
    expect(page).to have_content(post.title)
    expect(page).to have_content("Posted by: #{post.author.name}")
    expect(page).to have_content("Comments: #{post.comments.count}")
    expect(page).to have_content("Likes: #{post.likes.count}")
    expect(page).to have_content(post.text)

    post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
      expect(page).to have_content(comment.text)
    end

    expect(page).to have_css('form.new_comment')
    expect(page).to have_field('comment_text')
    expect(page).to have_button('Add Comment')

    expect(page).to have_css('form.new_like')
    expect(page).to have_button('Like')
  end
end
