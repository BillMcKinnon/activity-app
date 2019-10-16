Rails.application.routes.draw do
  root 'static_pages#home'
  get '/dashboard', to: 'dashboard#show'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/authorize', to: 'calendar#authorize'
  get '/redirect', to: 'calendar#redirect', as: 'redirect'
  get '/callback', to: 'calendar#callback', as: 'callback'
  get '/calendar_events', to: 'calendar_events#new'
  resources :users, only: [:create]
  resources :entries, only: [:create]
  resources :account_activations, only: [:edit]
  resources :password_resets, except: :destroy
end

