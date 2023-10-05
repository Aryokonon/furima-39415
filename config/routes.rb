Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :items

  get 'profile', to: 'profiles#show', as: 'user_profile'

  # Route for creating an order with a specific item

  # This route might not be necessary if you are using resources :items above, which automatically generates a route for update
  # patch '/items/:id', to: 'items#update', as: 'update_item'

  resources :items do
    resources :orders, only: [:index, :create]
  end
end
