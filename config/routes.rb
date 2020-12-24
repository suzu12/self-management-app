Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'nicknames', to: 'users/registrations#new_nickname'
    post 'nicknames', to: 'users/registrations#create_nickname'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'teams#index'
  resources :filtering_searchs, only: %i(index)

  resources :teams do
    resources :chats, only: :index
    resources :team_users, only: :create
    collection do
      get 'search'
    end
  end

  resources :accounts, only: :show do
    resource :following_list, only: :show
    resource :follower_list, only: :show
  end

  scope module: :apps do
    resource :timeline, only: %i(show)
    resource :profile, only: %i(show edit update)
    resources :favorites, only: %i(index)
  end

  namespace :api, default: {format: :json} do
    scope '/teams/:team_id' do
      resources :comments, only: %i(index create)
      resource :like, only: %i(show create destroy)
    end

    scope '/accounts/:account_id' do
      resources :follows, only: %i(index create)
      resources :unfollows, only: :create
    end

  end
end