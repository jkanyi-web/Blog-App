Rails.application.routes.draw do
  root "users#index"

  devise_for :users
  post '/auth/sign_in', to: 'sessions#create'

  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  resources :users, only: [:index, :show, :update] do
    collection do
      get 'complete_profile'
    end

    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  # API routes
  namespace :api do
  namespace :v1 do
    resources :users do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end
end

  get "up" => "rails/health#show", as: :rails_health_check
end
