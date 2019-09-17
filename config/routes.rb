Rails.application.routes.draw do
  root 'static_pages#home'
  get '/dashboard', to: 'dashboard#show'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:create]
  resources :entries, only: [:create]
  resources :account_activations, only: [:edit]
  resources :password_resets, except: :destroy
end

