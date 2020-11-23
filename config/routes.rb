Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'teams#index'
  resources :teams do
    resources :chats, only: %i(index create)
  end
  resource :profile, only: %i(show edit update)
end