Rails.application.routes.draw do
  root "users#index"

  devise_for :users

  resources :users, only: [:index, :show, :update] do
    collection do
      get 'complete_profile'
    end

    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
