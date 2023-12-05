require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('This is a placeholder for the list of all users.')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      user = User.create!(name: 'Test User', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('This is a placeholder for a single user.')
    end
  end
end
