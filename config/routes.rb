Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'users#index'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
