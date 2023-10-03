Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :items

  get 'profile', to: 'profiles#show', as: 'user_profile'

  # Route for creating an order with a specific item
  get '/orders/new', to: 'orders#new', as: 'new_order'

  # Keep the resources route for creating orders
  resources :orders, only: [:new, :create], constraints: { id: /\d+/ }, as: 'orders_with_id'

  resources :orders, only: [:new, :create, :index], constraints: { id: /\d+/ }, as: 'orders_with_id' do
    collection do
      get 'search'
    end

    resources :orders do
      get 'new', on: :member
    end
  

  end

  # This route might not be necessary if you are using resources :items above, which automatically generates a route for update
  # patch '/items/:id', to: 'items#update', as: 'update_item'

  resources :users, constraints: { id: /\d+/ } do
    resources :orders, only: [:index, :show, :new, :create]
  end
end
