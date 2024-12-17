Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

   root to:'items#index'
  resources :items, only:[:index,:new,:create]
  resources :buys, only: :index
  # Defines the root path route ("/")
  # root "articles#index"
end
