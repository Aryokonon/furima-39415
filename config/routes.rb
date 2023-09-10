Rails.application.routes.draw do

  # Root route
  root to: 'items#index' # This sets the root URL of your application to point to the 'index' action of the 'items' controller.
  
  # Routes for articles
  get 'articles/index'   # This sets up a route for the 'index' action of the 'articles' controller.
  get 'articles/new'     # This sets up a route for the 'new' action of the 'articles' controller.
  resources :articles    # This line generates RESTful routes for the 'articles' resource, including 'index', 'new', 'create', 'edit', 'update', 'show', and 'destroy' actions.

  # Routes for orders
  resources :orders, only: [:create] # This generates routes for the 'create' action of the 'orders' controller, restricting other actions.

  # You can uncomment the following line if you want the root path to point to the 'orders#index' action.
  # root to: 'orders#index'
end