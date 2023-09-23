Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  get 'profile', to: 'profiles#show', as: 'user_profile'

  resources :items, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
    collection do
      get 'search'
    end
  end

  resources :orders, only: [:create]

  resources :users, constraints: { id: /\d+/ } do
    resources :orders, only: [:index, :show, :new, :create]
  end
end