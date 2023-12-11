require 'rails_helper'

RSpec.describe 'Users Index Page', type: :system do
  before do
    @users = create_list(:user, 5)
    visit users_path
  end

  it 'displays user name, photo and total posts number on the users index page' do
    @users.each do |user|
      within find('.jumbotron', text: user.name) do
        expect(page).to have_content(user.name)
        expect(page).to have_css('img.user-image')
        expect(page).to have_content("Number of posts: #{user.posts.count}")
      end
    end
  end

  it 'redirects to user show page when clicking on user\'s name' do
    user = @users.sample
    within find('.jumbotron', text: user.name) do
      click_link user.name
    end
    expect(page).to have_current_path(user_path(user))
  end
end
