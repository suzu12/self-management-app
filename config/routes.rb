Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'teams#index'

  resources :teams do
    resources :chats, only: %i(index create)
    resources :team_users, only: :create
    resources :comments, only: %i(index create)
    resource :like, only: %i(show create destroy)
    collection do
      get 'search'
    end
  end

  resources :accounts, only: :show do
    resources :follows, only: :create
    resources :unfollows, only: :create
  end

  resource :profile, only: %i(show edit update)
  resources :favorites, only: %i(index)
end