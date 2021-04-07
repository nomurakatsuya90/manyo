Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/new'
    get 'users/edit'
    get 'users/show'
  end
  get 'sessions/new'
  namespace :admin do
    resources :users
  end
  resources :tasks
  root to: 'tasks#index'
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
