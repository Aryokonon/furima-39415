Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  # Root route
  root to: 'items#index' # Set the root URL of your application to the 'index' action of the 'items' controller.

  # Routes for items
  resources :items, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
    collection do
      get 'search' # Define a custom search action for items
    end
  end

  # Routes for orders
  resources :orders, only: [:create]

  resources :users do
    resources :orders, only: [:index, :show, :new, :create]
  end
end