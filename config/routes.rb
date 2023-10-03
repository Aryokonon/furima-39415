Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  get 'profile', to: 'profiles#show', as: 'user_profile'

  # Route for creating an order with a specific item
  get '/orders/new/:item_id', to: 'orders#new', as: 'new_order_with_item'

  # Separate resources route for orders with constraints to ensure ID is a number
  resources :orders, only: [:new, :create], constraints: { id: /\d+/ }

  resources :items, only: [:index, :new, :create, :edit, :update, :show, :destroy], constraints: { id: /\d+/ } do
    collection do
      get 'search'
      resources :orders, only: [:new, :create, :index]
    end
  end

  # This route might not be necessary if you are using resources :items above which automatically generates a route for update
  # patch '/items/:id', to: 'items#update', as: 'update_item'

  resources :users, constraints: { id: /\d+/ } do
    resources :orders, only: [:index, :show, :new, :create]
  end
end
