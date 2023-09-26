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
  get '/orders/new/:item_id', to: 'orders#new', as: 'new_order'


  resources :users, constraints: { id: /\d+/ } do
    resources :orders, only: [:index, :show, :new, :create]
  end

  patch '/items/:id', to: 'items#update', as: 'update_item'

end