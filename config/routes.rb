Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  get 'profile', to: 'profiles#show', as: 'user_profile'

  resources :items, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
    collection do
      get 'search'
      resources :orders, only: [:new, :create]
    end
  end

  # Route for creating new orders
  resources :orders, only: [:new, :create]

  # Route for creating an order with a specific item
  get '/orders/new/:item_id', to: 'orders#new', as: 'new_order_with_item'

  # Route for listing orders (index action)
  get '/orders', to: 'orders#index'

  resources :users, constraints: { id: /\d+/ } do
    resources :orders, only: [:index, :show, :new, :create]
  end

  # Route for updating an item
  patch '/items/:id', to: 'items#update', as: 'update_item'
end 