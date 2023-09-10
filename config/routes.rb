Rails.application.routes.draw do
  get 'articles/index'
  get 'articles/new'
   root to: 'articles#index'
  resources :articles

 # root to: 'orders#index'
  resources :orders, only:[:create]
  
end