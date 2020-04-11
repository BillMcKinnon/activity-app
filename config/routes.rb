Rails.application.routes.draw do
  root 'static_pages#home'
  get '/privacy', to: 'static_pages#privacy'
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
  resources :activities, only: [:show]
  resources :entries, only: [:create, :edit, :update, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, except: :destroy
  resources :calendar_events, only: [:new]
end

