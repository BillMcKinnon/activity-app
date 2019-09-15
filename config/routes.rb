Rails.application.routes.draw do
  get 'password_resets/new'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:show]
  resources :entries
  resources :account_activations, only: [:edit]
  resources :password_resets
end

